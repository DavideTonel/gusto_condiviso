import 'dart:async';
import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/promos/promo.dart';
import 'package:meta/meta.dart';

part 'promo_event.dart';
part 'promo_state.dart';


class PromoBloc extends Bloc<PromoEvent, PromoState> {
  PromoBloc() : super(const PromoInitial()) {
    on<LoadPromoRequest>(onLoadPromoRequest);
  }

  FutureOr<void> onLoadPromoRequest(
    LoadPromoRequest event,
    Emitter<PromoState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/promo",
        data: {
          "id": event.id,
        }
      ).then((value) {
        final id = value.data["Codice"] as int;
        final name = value.data["Nome"] as String;
        final description = value.data["Descrizione"] as String;
        final useInstructions = value.data["IstruzioniUso"] as String;
        final endDate = value.data["DataScadenza"] as String;
        final companyId = value.data["UsernameAzienda"] as String;

        emit(
          PromoLoaded(
            promo: Promo(
              id: id,
              name: name,
              description: description,
              useInstructions: useInstructions,
              endDate: endDate,
              companyId: companyId,
            ),
          )
        );
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }
}
