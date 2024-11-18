import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/user/subscription_type.dart';
import 'package:gusto_condiviso/model/user/user.dart';
import 'package:meta/meta.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  UserLoginBloc() : super(UserLoginInitial()) {
    on<LoginRequestEvent>(onLoginRequestEvent);
  }

  FutureOr<void> onLoginRequestEvent(
    LoginRequestEvent event,
    Emitter<UserLoginState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/loginRequest",
        data: {
          "username": event.username,
          "password": event.password
        }
      ).then((value) {
        if (value.data != null) {
          dev.log("LoginSuccess");

          /*
          final user = User(
            username: value.data["Username"] as String,
            password: value.data["Password"] as String,
            name: value.data["Nome"] as String,
            surname: value.data["Cognome"] as String,
            mail: value.data["Mail"] as String,
            birthday: value.data["DataNascita"] as String      // TODO aggiustare data, il giorno è sempre -1
          );
          */

          final username = value.data["Username"] as String;
          final password = value.data["Password"] as String;
          final name = value.data["Nome"] as String;
          final surname = value.data["Cognome"] as String;
          final mail = value.data["Mail"] as String;
          final birthday = value.data["DataNascita"] as String;     // TODO aggiustare data, il giorno è sempre -1
          

          try {
            final startDateSubscription = value.data["DataInizio"] as String; // TODO aggiustare data
            final subscriptionTypeId = value.data["CodiceTipoAbbonamento"] as int;
            final subscriptionTypeName = value.data["NomeTipo"] as String;
            final subscriptionTypeDescription = value.data["Descrizione"] as String;
            final subscriptionTypePricePerMonth = value.data["PrezzoMensile"] as String;

            emit(UserLoginSuccess(
              user: User(
                username: username,
                password: password,
                name: name,
                surname: surname,
                mail: mail,
                birthday: birthday,
                subscription: UserSubscription(
                  startDate: startDateSubscription,
                  subscriptionType: SubscriptionType(
                    id: subscriptionTypeId,
                    name: subscriptionTypeName,
                    description: subscriptionTypeDescription,
                    price: subscriptionTypePricePerMonth
                  )
                )
              ),
            )); 
          } catch (e) {
            dev.log("No subscription");

            emit(UserLoginSuccess(
              user: User(
                username: username,
                password: password,
                name: name,
                surname: surname,
                mail: mail,
                birthday: birthday
              )
            ));
          }
        } else {
          dev.log("LoginFailure");
          emit(UserLoginFailure(errorMessage: "Username o password sbagliati"));
        }
      });
    } catch (e) {
      dev.log("Errore");
      dev.log(e.toString());
      emit(UserLoginFailure(errorMessage: e.toString()));
    }
  }
}
