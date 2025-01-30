import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/promos/promo/promo_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/user/user_promos_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/widgets/promos/promo_preview.dart';


class UserPromosFeedPage extends StatelessWidget {
  const UserPromosFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<UserPromosBloc, UserPromosState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: size.width,
              height: 10,
            ),

            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 45.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<UserPromosBloc>().add(
                                LoadPromosForUserRequest()
                              );
                              context.read<UserPromosBloc>().add(
                                LoadPromosActivatedByUser(
                                  userId: context.read<UserBloc>().state.user!.username
                                )
                              );
                            },
                            child: const Text(
                              "Aggiorna Pagina",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            SizedBox(
              //color: Colors.amber,
              width: size.width,
              //height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Promozioni per me",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.feedPromos.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: PromoPreviewWidget(
                    id: elem.id,
                    name: elem.name,
                    endDate: elem.endDate,
                    onTap: () {
                      context.read<PromoBloc>().add(
                        LoadPromoRequest(
                          id: elem.id
                        )
                      );

                      context.read<UserPromosBloc>().add(
                        GetSingleUseCode(
                          userId: context.read<UserBloc>().state.user!.username,
                          promoId: elem.id
                        )
                      );

                      final router = GoRouter.of(context);
                      router.push("/userPromo");
                    },
                  ),
                )).toList(),
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            SizedBox(
              //color: Colors.amber,
              width: size.width,
              //height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Promozioni attivate",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.enrolledPromos.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: PromoPreviewWidget(
                    id: elem.id,
                    name: elem.name,
                    endDate: elem.endDate,
                    onTap: () {
                      context.read<PromoBloc>().add(
                        LoadPromoRequest(
                          id: elem.id
                        )
                      );

                      context.read<UserPromosBloc>().add(
                        GetSingleUseCode(
                          userId: context.read<UserBloc>().state.user!.username,
                          promoId: elem.id
                        )
                      );

                      final router = GoRouter.of(context);
                      router.push("/userPromo");
                    },
                  ),
                )).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
