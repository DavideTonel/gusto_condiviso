import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/company/company_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/company/company_promos_bloc.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/teacher/teacher_video_classes_bloc.dart';

import 'dart:developer' as dev;

class PromoCreationPage extends StatefulWidget {
  const PromoCreationPage({super.key});

  @override
  PromoCreationPageState createState() => PromoCreationPageState();
}

class PromoCreationPageState extends State<PromoCreationPage> {
  final promoNameTextController = TextEditingController();
  final promoDescriptionTextController = TextEditingController();
  final promoUseInstructionsTextController = TextEditingController();
  final promoEndDateTextController = TextEditingController();

  @override
  void dispose() {
    promoNameTextController.dispose();
    promoDescriptionTextController.dispose();
    promoUseInstructionsTextController.dispose();
    promoEndDateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<CompanyPromosBloc, CompanyPromosState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Creazione Promozione",
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: promoNameTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome promozione"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: promoDescriptionTextController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descrizione"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: promoUseInstructionsTextController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Istruzioni d'uso"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: promoEndDateTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Data scadenza",
                    hintText: "YYYY-MM-DD"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.1,
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (
                          promoNameTextController.text.isNotEmpty &&
                          promoDescriptionTextController.text.isNotEmpty &&
                          promoEndDateTextController.text.isNotEmpty &&
                          promoUseInstructionsTextController.text.isNotEmpty
                        ) {
                          context.read<CompanyPromosBloc>().add(
                            SavePromoRequest(
                              companyId: context.read<CompanyBloc>().state.company!.username,
                              name: promoNameTextController.text,
                              description: promoDescriptionTextController.text,
                              useInstructions: promoUseInstructionsTextController.text,
                              endDate: promoEndDateTextController.text
                            )
                          );
                          final router = GoRouter.of(context);
                          router.pop();  
                        }
                      },
                      child: const Text(
                        "Fine",
                        style: TextStyle(fontSize: 24),
                      )
                    ),

                    SizedBox(
                      height: size.height * 0.05,
                    )
                  ],
                ),
              )
            ]
          )
        );
      },
    );
  }
}
