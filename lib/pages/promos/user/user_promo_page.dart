import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/promos/promo/promo_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/user/user_promos_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';

class UserPromoPage extends StatelessWidget {
  const UserPromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<PromoBloc, PromoState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<UserPromosBloc>().add(ClearCurrentOneshotCode());
                context.read<UserPromosBloc>().add(LoadPromosForUserRequest());
                context.read<UserPromosBloc>().add(
                  LoadPromosActivatedByUser(
                    userId: context.read<UserBloc>().state.user!.username
                  )
                );
                final router = GoRouter.of(context);
                router.pop();
              },
              icon: const Icon(Icons.arrow_back)
            ),
            title: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
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
                      "Scadenza: ${state.promo?.endDate}",
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
                    child: Text(state.promo?.description ??
                        "descrizione non disponibile"),
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
              SizedBox(
                height: size.height * 0.05,
              ),
              BlocBuilder<UserPromosBloc, UserPromosState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: state.currentPromoOneshotCode != null
                          ? null
                          : () {
                            context.read<UserPromosBloc>().add(
                              ActivatePromoRequest(
                                userId: context.read<UserBloc>().state.user!.username,
                                promoId: context.read<PromoBloc>().state.promo!.id
                              )
                            );
                          },
                        child: const Text("Ottieni")
                      ),

                      if (state.currentPromoOneshotCode != null)
                        SizedBox(
                          height: size.height * 0.05,
                        ),

                      if (state.currentPromoOneshotCode != null)
                        Text("Codice Monouso: ${state.currentPromoOneshotCode}")
                    ],
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
