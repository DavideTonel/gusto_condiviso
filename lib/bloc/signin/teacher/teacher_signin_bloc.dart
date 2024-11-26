import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:meta/meta.dart';

part 'teacher_signin_event.dart';
part 'teacher_signin_state.dart';

class TeacherSigninBloc extends Bloc<TeacherSigninEvent, TeacherSigninState> {
  TeacherSigninBloc() : super(TeacherSigninInitial()) {
    on<SigninRequestEvent>(onSigninRequestEvent);
  }

  FutureOr<void> onSigninRequestEvent(
    SigninRequestEvent event,
    Emitter<TeacherSigninState> emit
  ) async {
    var client = DioClient();
    await client.dio.post(
      "api/teacherSigninRequest",
      data: {
        "username": event.username,
        "mail": event.mail,
        "password": event.password,
        "name": event.name,
        "surname": event.surname,
        "birthday": event.birthday,
        "description": event.description
      }
    ).then((value) {
      if (value.data) {
        emit(TeacherSigninSuccess());
      } else {
        emit (TeacherSigninFailure(errorMessage: "Username esiste già"));
      }
    });
  }
}
