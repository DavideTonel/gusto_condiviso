import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/company/company_bloc.dart';
import 'package:gusto_condiviso/bloc/navigation/navigation_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/company/company_promos_bloc.dart';

import 'dart:developer' as dev;

import 'package:gusto_condiviso/pages/profiles/company_profile_page.dart';
import 'package:gusto_condiviso/pages/promos/company_promos_page.dart';

class CompanyHomePage extends StatelessWidget {
  const CompanyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationRailIndex = 0;

    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        switch (state) {
          case NavigationCompanyHomeProfileInfo _: {
            navigationRailIndex = 0;
          }
          case NavigationCompanyHomePromoCodes _: {
            navigationRailIndex = 1;
          }
          default: {
            navigationRailIndex = 0;
          }
        }
      },
      builder: (context, state) {
        return BlocConsumer<CompanyBloc, CompanyState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NavigationRail(
                      selectedIndex: navigationRailIndex,
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.account_circle),
                          icon: Icon(Icons.account_circle_outlined),
                          label: Text("Profilo")
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.card_giftcard),
                          icon: Icon(Icons.card_giftcard_outlined),
                          label: Text("Promozioni"),
                        ),
                      ],
                      onDestinationSelected: (value) {
                        switch (value) {
                          case 0: {
                            context.read<NavigationBloc>().add(NavigateToCompanyHomeProfileInfo());
                          }
                          case 1: {
                            context.read<NavigationBloc>().add(NavigateToCompanyHomePromoCodes());
                            context.read<CompanyPromosBloc>().add(
                              LoadPromosMadeByCompanyRequest(
                                companyId: state.company!.username
                              )
                            );
                          }
                          default: {
                            context.read<NavigationBloc>().add(NavigateToCompanyHomeProfileInfo());
                          }
                        }
                      },
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    width: 1,
                  ),
                  Expanded(
                    child: switch (navigationRailIndex) {
                      0 => const CompanyProfilePage(),
                      1 => const CompanyPromosPage(),
                      _ => const CompanyProfilePage()
                    }
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
