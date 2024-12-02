import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/teacher/teacher.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'teacher_login_event.dart';
part 'teacher_login_state.dart';

class TeacherLoginBloc extends Bloc<TeacherLoginEvent, TeacherLoginState> {
  TeacherLoginBloc() : super(TeacherLoginInitial()) {
    on<LoginRequestEvent>(onLoginRequestEvent);
  }

  FutureOr<void> onLoginRequestEvent(
    LoginRequestEvent event,
    Emitter<TeacherLoginState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/teacherLoginRequest",
        data: {
          "username": event.username,
          "password": event.password
        }
      ).then((value) {
        if (value.data != null) {
          final username = value.data["Username"] as String;
          final password = value.data["Password"] as String;
          final name = value.data["Nome"] as String;
          final surname = value.data["Cognome"] as String;
          final mail = value.data["Mail"] as String;
          final birthday = DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data["DataNascita"] as String));
          final description = value.data["Descrizione"] as String;

          emit(
            TeacherLoginSuccess(
              teacher: Teacher(
                username: username,
                password: password,
                name: name,
                surname: surname,
                mail: mail,
                birthday: birthday,
                description: description
              )
            )
          );
        } else {
          emit(TeacherLoginFailure(errorMessage: "Username o password sbagliati"));
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
      emit(TeacherLoginFailure(errorMessage: e.toString()));
    }
  }
}
