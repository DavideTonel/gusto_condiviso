import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/user/subscription_type.dart';
import 'package:gusto_condiviso/model/user/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {
    on<SetUser>((event, emit) {
      emit(UserLoaded(user: event.user));
    });

    on<SetSubscription>(onSetSubscription);

  }

  FutureOr<void> onSetSubscription(
    SetSubscription event,
    Emitter<UserState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/setSubscription",
        data: {
          "userUsername": state.user!.username,
          "subscriptionTypeId": event.subscriptionType.id
        }
      ).then((value) {
        if (value.data != null) {
          
          emit(UserLoaded(
            user: User(
              username: state.user!.username,
              password: state.user!.password,
              name: state.user!.name,
              surname: state.user!.surname,
              mail: state.user!.mail,
              birthday: state.user!.birthday,
              subscription: UserSubscription(
                startDate: value.data["DataInizio"] as String,
                subscriptionType: SubscriptionType(
                  id: value.data["CodiceTipoAbbonamento"] as int,
                  name: value.data["NomeTipo"] as String, 
                  description: value.data["Descrizione"] as String,
                  price: value.data["PrezzoMensile"] as String
                )
              )
            ),
          ));
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
