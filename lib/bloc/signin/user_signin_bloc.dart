import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:meta/meta.dart';

part 'user_signin_event.dart';
part 'user_signin_state.dart';

class UserSigninBloc extends Bloc<UserSigninEvent, UserSigninState> {
  UserSigninBloc() : super(UserSigninInitial()) {
    on<SigninRequestEvent>(onSigninRequestEvent);
  }

  FutureOr<void> onSigninRequestEvent(
    SigninRequestEvent event,
    Emitter<UserSigninState> emit
  ) async {
    var client = DioClient();
    await client.dio.post(
      "api/signinRequest",
      data: {
        "username": event.username,
        "mail": event.mail,
        "password": event.password,
        "name": event.name,
        "surname": event.surname,
        "birthday": event.birthday
      }
    ).then((value) {
      if (value.data) {
        emit(UserSigninSuccess());
      } else {
        emit (UserSigninFailure(errorMessage: "Username esiste già"));
      }
    });
  }
}
