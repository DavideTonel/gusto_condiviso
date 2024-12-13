import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/admin/admin.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'admin_login_event.dart';
part 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  AdminLoginBloc() : super(AdminLoginInitial()) {
    on<LoginRequestEvent>(onLoginRequestEvent);
  }

  FutureOr<void> onLoginRequestEvent(
    LoginRequestEvent event,
    Emitter<AdminLoginState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/adminLoginRequest",
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
                       
          emit(
            AdminLoginSuccess(
              admin: Admin(
                username: username,
                password: password,
                name: name,
                surname: surname,
                mail: mail,
                birthday: birthday
              )
            )
          );
        } else {
          emit(AdminLoginFailure(errorMessage: "Username o password sbagliati"));
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
      emit(AdminLoginFailure(errorMessage: e.toString()));
    }
  }
}
