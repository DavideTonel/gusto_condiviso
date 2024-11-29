import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:meta/meta.dart';

part 'company_signin_event.dart';
part 'company_signin_state.dart';

class CompanySigninBloc extends Bloc<CompanySigninEvent, CompanySigninState> {
  CompanySigninBloc() : super(CompanySigninInitial()) {
    on<SigninRequestEvent>(onSigninRequestEvent);
  }

  FutureOr<void> onSigninRequestEvent(
    SigninRequestEvent event,
    Emitter<CompanySigninState> emit
  ) async {
    var client = DioClient();
    await client.dio.post(
      "api/companySigninRequest",
      data: {
        "username": event.username,
        "password": event.password,
        "name": event.name,
        "mail": event.mail,
        "linkWebSite": event.linkWebSite,
      }
    ).then((value) {
      if (value.data) {
        emit(CompanySigninSuccess());
      } else {
        emit (CompanySigninFailure(errorMessage: "Username esiste già"));
      }
    });
  }
}
