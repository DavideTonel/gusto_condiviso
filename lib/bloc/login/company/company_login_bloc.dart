import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/company/company.dart';
import 'package:meta/meta.dart';

part 'company_login_event.dart';
part 'company_login_state.dart';

class CompanyLoginBloc extends Bloc<CompanyLoginEvent, CompanyLoginState> {
  CompanyLoginBloc() : super(CompanyLoginInitial()) {
    on<LoginRequestEvent>(onLoginRequestEvent);
  }

  FutureOr<void> onLoginRequestEvent(
    LoginRequestEvent event,
    Emitter<CompanyLoginState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/companyLoginRequest",
        data: {
          "username": event.username,
          "password": event.password
        }
      ).then((value) {
        if (value.data != null) {
          final username = value.data["Username"] as String;
          final password = value.data["Password"] as String;
          final name = value.data["Nome"] as String;
          final mail = value.data["Mail"] as String;
          final link = value.data["LinkSitoWeb"] as String;

          emit(
            CompanyLoginSuccess(
              company: Company(
                username: username,
                password: password,
                name: name,
                mail: mail,
                linkWebsite: link
              )
            )
          );
        } else {
          dev.log("LoginFailure");
          emit(CompanyLoginFailure(errorMessage: "Username o password sbagliati"));
        }
      });
    } catch (e) {
      dev.log("Errore");
      dev.log(e.toString());
      emit(CompanyLoginFailure(errorMessage: e.toString()));
    }
  }
}
