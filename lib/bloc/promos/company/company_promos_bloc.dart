import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/promos/promo.dart';
import 'package:meta/meta.dart';

part 'company_promos_event.dart';
part 'company_promos_state.dart';

class CompanyPromosBloc extends Bloc<CompanyPromosEvent, CompanyPromosState> {
  CompanyPromosBloc() : super(const CompanyPromosInitial()) {
    on<LoadPromosMadeByCompanyRequest>(onLoadPromosMadeByCompanyRequest);

    on<SavePromoRequest>(onSavePromoRequest);
  }

  FutureOr<void> onLoadPromosMadeByCompanyRequest(
    LoadPromosMadeByCompanyRequest event,
    Emitter<CompanyPromosState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/promosMadeByCompany",
        data: {
          "id": event.companyId
        }
      ).then((value) {
        List<Promo> promos = [];
        for(dynamic entry in value.data) {
          promos.add(
            Promo(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              description: entry["Descrizione"] as String,
              endDate: entry["DataScadenza"] as String,
              useInstructions: entry["IstruzioniUso"] as String,
              companyId: event.companyId
            )
          );
        }
        emit(
          CompanyPromosLoaded(
            promos: promos,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSavePromoRequest(
    SavePromoRequest event,
    Emitter<CompanyPromosState> emit
  ) async {
    try {
      final client = DioClient();
      await client.dio.post(
        "api/savePromo",
        data: {
          "companyId": event.companyId,
          "name": event.name,
          "description": event.description,
          "endDate": event.endDate,
          "useInstructions": event.useInstructions,
        }
      ).then((value) async {
        await client.dio.post(
          "api/promosMadeByCompany",
          data: {
            "id": event.companyId
          }
        ).then((value) {
          List<Promo> promos = [];
          for(dynamic entry in value.data) {
            promos.add(
              Promo(
                id: entry["Codice"] as int,
                name: entry["Nome"] as String,
                description: entry["Descrizione"] as String,
                endDate: entry["DataScadenza"] as String,
                useInstructions: entry["IstruzioniUso"] as String,
                companyId: event.companyId
              )
            );
          }
          emit(
            CompanyPromosLoaded(
              promos: promos,
            )
          );
        });
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    } 
  }
}
