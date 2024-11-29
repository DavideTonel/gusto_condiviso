import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/company/company_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/company/company_promos_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/promo/promo_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_class/video_class_bloc.dart';
import 'package:gusto_condiviso/widgets/promos/promo_preview.dart';



class CompanyPromosPage extends StatelessWidget {
  const CompanyPromosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<CompanyPromosBloc, CompanyPromosState>(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              final router = GoRouter.of(context);
                              router.push("/promoCreation");
                            },
                            child: const Text(
                              "Crea Promozione",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            context.read<CompanyPromosBloc>().add(
                              LoadPromosMadeByCompanyRequest(
                                companyId: context.read<CompanyBloc>().state.company!.username
                              )
                            );
                          },
                          child: const Text(
                            "Aggiorna Pagina",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: size.width,
              height: 15,
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
                      "Le mie promozioni",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.promos.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: PromoPreviewWidget(
                    name: elem.name,
                    endDate: elem.endDate,
                    id: elem.id,
                    onTap: () {
                      context.read<PromoBloc>().add(
                        LoadPromoRequest(
                          id: elem.id,
                        )
                      );
                      final router = GoRouter.of(context);
                      router.push("/promo");
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
