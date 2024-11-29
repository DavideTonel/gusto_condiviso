import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/promo/promo_bloc.dart';

import 'dart:developer' as dev;

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<PromoBloc, PromoState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.promo?.name ?? "nome non disponibile",
                    style: const TextStyle(fontSize: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "creata da azienda ${state.promo?.companyId ?? "username non disponibile"}",
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.005,
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Scadenza: ${state.promo?.endDate}", //TODO aggiungere data
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(state.promo?.description ?? "descrizione non disponibile"),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Istruzioni d'uso: ${state.promo?.useInstructions}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
