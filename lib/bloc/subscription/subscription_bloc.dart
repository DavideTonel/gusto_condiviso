import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/user/subscription_type.dart';
import 'package:meta/meta.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  SubscriptionsBloc() : super(SubscriptionInitial()) {
    on<LoadSubscriptionTypesRequest>(onLoadSubscriptionsRequest);
  }


  FutureOr<void> onLoadSubscriptionsRequest(
    LoadSubscriptionTypesRequest event,
    Emitter<SubscriptionsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/subscriptions"
      ).then((value) {
        List<SubscriptionType> subsciptionTypes = [];
        for (dynamic entry in value.data) {
          subsciptionTypes.add(
            SubscriptionType(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              description: entry["Descrizione"] as String,
              price: entry["PrezzoMensile"] as String
            )
          );
        }
        emit(SubscriptionsTypeLoaded(subscriptionTypes: subsciptionTypes));
      });


    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
