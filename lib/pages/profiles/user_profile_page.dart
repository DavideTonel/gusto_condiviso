import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';

import 'dart:developer' as dev;

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 70,
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Informazioni Profilo",
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: size.height * 0.01,
                      ),

                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Nome: ${state.user?.name ?? "Non disponibile"}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Cognome: ${state.user?.surname ?? "Non disponibile"}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Data di nascita: ${state.user?.birthday ?? "Non disponibile"}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Mail: ${state.user?.mail ?? "Non disponibile"}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Username: ${state.user?.username ?? "Non disponibile"}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Password: ${state.user?.password ?? "Non disponibile"}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Abbonamento: ${state.user?.subscription?.subscriptionType.name ?? "Nessun abbonamento"}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Data iscrizione abbonamento: ${state.user?.subscription?.startDate ?? "Nessun abbonamento"}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.width,
                        height: 70,
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Storico abbonamenti",
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.25,
                        child: ListView(
                          children: state.pastSubscriptions.map((elem) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                            child: ListTile(
                              title: Text(elem.subscriptionType.name),
                              subtitle: Row(
                                children: [
                                  Text("Inizio: ${elem.startDate}"),

                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),

                                  Text("Fine: ${elem.endDate ?? "no data"}")
                                ],
                              ),
                            )
                          )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
