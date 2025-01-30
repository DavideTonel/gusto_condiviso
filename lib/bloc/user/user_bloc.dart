import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/user/subscription_type.dart';
import 'package:gusto_condiviso/model/user/user.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {
    on<SetUser>(onSetUser);

    on<SetSubscription>(onSetSubscription);

    on<CancelSubscription>(onCancelSubscription);
  }

  FutureOr<void> onSetUser(
    SetUser event,
    Emitter<UserState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/userSubscriptionsHistory",
        data: {
          "userUsername": event.user.username
        }
      ).then((value) {
        List<UserSubscription> pastSubscriptions = [];
        if (value.data != null) {
          for (dynamic entry in value.data) {
            pastSubscriptions.add(
              UserSubscription(
                id: entry["Codice"] as int,
                startDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataInizio"] as String)),
                endDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataFine"] as String)),
                subscriptionType: SubscriptionType(
                  id: entry["CodiceTipoAbbonamento"] as int,
                  name: entry["Nome"] as String,
                  description: entry["Descrizione"] as String,
                  price: entry["PrezzoMensile"] as String
                )
              )
            );
          }
        }
        emit(UserLoaded(
          user: event.user,
          pastSubscriptions: pastSubscriptions
        ));
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
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
          "previousSubscriptionId": state.user!.subscription?.id,
          "subscriptionTypeId": event.subscriptionType.id
        }
      ).then((value) async {
        if (value.data != null) {
          final currentSubscription = UserSubscription(
            id: value.data["Codice"] as int,
            startDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data["DataInizio"] as String)),
            endDate: value.data["DataFine"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data["DataFine"] as String)) : null,
            subscriptionType: SubscriptionType(
              id: value.data["CodiceTipoAbbonamento"] as int,
              name: value.data["Nome"] as String, 
              description: value.data["Descrizione"] as String, 
              price: value.data["PrezzoMensile"] as String
            )
          );

          final user = User(
            username: state.user!.username,
            password: state.user!.password,
            name: state.user!.name,
            surname: state.user!.surname,
            mail: state.user!.mail,
            birthday: state.user!.birthday,
            subscription: currentSubscription
          );

          dev.log("sub id: ${currentSubscription.id}");
          dev.log("sub start date: ${currentSubscription.startDate}");
          dev.log("sub end date: ${currentSubscription.endDate}");
          dev.log("sub type id: ${currentSubscription.subscriptionType.id}");
          dev.log("sub type name: ${currentSubscription.subscriptionType.name}");
          dev.log("sub type description: ${currentSubscription.subscriptionType.description}");
          dev.log("sub type price: ${currentSubscription.subscriptionType.price}");

          await client.dio.post(
            "api/userSubscriptionsHistory",
            data: {
              "userUsername": state.user!.username
            }
          ).then((value) {
            List<UserSubscription> pastSubscriptions = [];
            for (dynamic entry in value.data) {
              pastSubscriptions.add(
                UserSubscription(
                  id: entry["Codice"] as int,
                  startDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataInizio"] as String)),
                  endDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataFine"] as String)),
                  subscriptionType: SubscriptionType(
                    id: entry["CodiceTipoAbbonamento"] as int,
                    name: entry["Nome"] as String,
                    description: entry["Descrizione"] as String,
                    price: entry["PrezzoMensile"] as String
                  )
                )
              );
            }

            emit(
              UserLoaded(
                user: user,
                pastSubscriptions: pastSubscriptions
              )
            );
          });
        }
      });
    } catch (e) {
      dev.log("Error in setSubscription");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onCancelSubscription(
    CancelSubscription event,
    Emitter<UserState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/deleteSubscription",
        data: {
          "userUsername": state.user!.username
        }
      ).then((value) async {
        if (value.data != null) {
          final user = User(
            username: state.user!.username,
            password: state.user!.password,
            name: state.user!.name,
            surname: state.user!.surname,
            mail: state.user!.mail,
            birthday: state.user!.birthday
          );

          await client.dio.post(
            "api/userSubscriptionsHistory",
            data: {
              "userUsername": state.user!.username
            }
          ).then((value) {
            List<UserSubscription> pastSubscriptions = [];
            for (dynamic entry in value.data) {
              pastSubscriptions.add(
                UserSubscription(
                  id: entry["Codice"] as int,
                  startDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataInizio"] as String)),
                  endDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataFine"] as String)),
                  subscriptionType: SubscriptionType(
                    id: entry["CodiceTipoAbbonamento"] as int,
                    name: entry["Nome"] as String,
                    description: entry["Descrizione"] as String,
                    price: entry["PrezzoMensile"] as String
                  )
                )
              );
            }
            emit(
              UserLoaded(
                user: user,
                pastSubscriptions: pastSubscriptions
              )
            );
          });
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
