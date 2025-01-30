import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/user/subscription_type.dart';
import 'package:gusto_condiviso/model/user/user.dart';
import 'package:intl/intl.dart';
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
        "api/userLoginRequest",
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
          
          try {
            final subscriptionId = value.data["Codice"] as int;
            final startDateSubscription = DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data["DataInizio"] as String));
            final endDate = value.data["DataFine"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data["DataFine"] as String)) : null;
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
                  id: subscriptionId,
                  startDate: startDateSubscription,
                  endDate: endDate,
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
          emit(UserLoginFailure(errorMessage: "Username o password sbagliati"));
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
      emit(UserLoginFailure(errorMessage: e.toString()));
    }
  }
}
