import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/promos/promo.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'user_promos_event.dart';
part 'user_promos_state.dart';

class UserPromosBloc extends Bloc<UserPromosEvent, UserPromosState> {
  UserPromosBloc() : super(const UserPromosInitial()) {
    on<LoadPromosForUserRequest>(onLoadPromosForUserRequest);

    on<LoadPromosActivatedByUser>(onLoadPromosActivatedByUser);

    on<ActivatePromoRequest>(onActivatePromoRequest);

    on<GetSingleUseCode>(onGetSingleUseCode);

    on<ClearCurrentOneshotCode>((event, emit) {
      emit(
        UserPromosLoaded(
          feedPromos: state.feedPromos,
          enrolledPromos: state.enrolledPromos
        )
      );
    });
  }

  FutureOr<void> onLoadPromosForUserRequest(
    LoadPromosForUserRequest event,
    Emitter<UserPromosState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/promosForUser",
      ).then((value) {
        List<Promo> promos = [];
        for(dynamic entry in value.data) {
          promos.add(
            Promo(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              description: entry["Descrizione"] as String,
              endDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataScadenza"] as String)),
              useInstructions: entry["IstruzioniUso"] as String,
              companyId: entry["UsernameAzienda"] as String
            )
          );
        }
        emit(
          UserPromosLoaded(
            feedPromos: promos,
            enrolledPromos: state.enrolledPromos,
            currentPromoOneshotCode: state.currentPromoOneshotCode
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadPromosActivatedByUser(
    LoadPromosActivatedByUser event,
    Emitter<UserPromosState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/promosActivatedByUser",
        data: {
          "userId": event.userId
        }
      ).then((value) {
        List<Promo> promos = [];
        for(dynamic entry in value.data) {
          promos.add(
            Promo(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              description: entry["Descrizione"] as String,
              endDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataScadenza"] as String)),
              useInstructions: entry["IstruzioniUso"] as String,
              companyId: entry["UsernameAzienda"] as String
            )
          );
        }
        emit(
          UserPromosLoaded(
            feedPromos: state.feedPromos,
            enrolledPromos: promos,
            currentPromoOneshotCode: state.currentPromoOneshotCode
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onActivatePromoRequest(
    ActivatePromoRequest event,
    Emitter<UserPromosState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/activatePromo",
        data: {
          "userId": event.userId,
          "promoId": event.promoId
        }
      ).then((value) {
        try {
          emit (
            UserPromosLoaded(
              feedPromos: state.feedPromos,
              enrolledPromos: state.enrolledPromos,
              currentPromoOneshotCode: value.data[0]["CodiceMonouso"] as String
            )
          );
        } catch (e) {
          emit (
            UserPromosLoaded(
              feedPromos: state.feedPromos,
              enrolledPromos: state.enrolledPromos,
              currentPromoOneshotCode: null
            )
          );
        }
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onGetSingleUseCode(
    GetSingleUseCode event,
    Emitter<UserPromosState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/getPromoSingleUseCode",
        data: {
          "userId": event.userId,
          "promoId": event.promoId
        }
      ).then((value) {
        emit(
          UserPromosLoaded(
            feedPromos: state.feedPromos,
            enrolledPromos: state.enrolledPromos,
            currentPromoOneshotCode: value.data[0]["CodiceMonouso"] as String
          )
        );
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }
}
