import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/admin/admin_bloc.dart';
import 'package:gusto_condiviso/bloc/navigation/navigation_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/categories/recipe_categories_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/ingredients/ingredients_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/tools/tools_bloc.dart';
import 'package:gusto_condiviso/bloc/statistics/admin_statistics/admin_statistics_bloc.dart';
import 'package:gusto_condiviso/pages/profiles/admin_profile_page.dart';
import 'package:gusto_condiviso/pages/recipes/admin/admin_ingredients_page.dart';
import 'package:gusto_condiviso/pages/recipes/admin/admin_recipes_categories_page.dart';
import 'package:gusto_condiviso/pages/recipes/admin/admin_tools_page.dart';
import 'package:gusto_condiviso/pages/statistics/admin_statistics_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationRailIndex = 0;

    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        switch (state) {
          case NavigationAdminHomeProfileInfo _: {
            navigationRailIndex = 0;
          }
          case NavigationAdminHomeRecipeCategories _: {
            navigationRailIndex = 1;
          }
          case NavigationAdminHomeIngredients _: {
            navigationRailIndex = 2;
          }
          case NavigationAdminHomeTools _: {
            navigationRailIndex = 3;
          }
          case NavigationAdminHomeStatistics _: {
            navigationRailIndex = 4;
          }
          default: {
            navigationRailIndex = 0;
          }
        }
      },
      builder: (context, state) {
        return BlocConsumer<AdminBloc, AdminState>(
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
                          selectedIcon: Icon(Icons.receipt_long),
                          icon: Icon(Icons.receipt_long_outlined),
                          label: Text("Categorie Ricette"),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.fastfood),
                          icon: Icon(Icons.fastfood_outlined),
                          label: Text("Ingredienti"),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.architecture),
                          icon: Icon(Icons.architecture_outlined),
                          label: Text("Utensili"),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.stacked_bar_chart),
                          icon: Icon(Icons.stacked_bar_chart_outlined),
                          label: Text("Statistiche"),
                        ),
                      ],
                      onDestinationSelected: (value) {
                        switch (value) {
                          case 0: {
                            context.read<NavigationBloc>().add(NavigateToAdminHomeProfileInfo());
                          }
                          case 1: {
                            context.read<RecipeCategoriesBloc>().add(LoadRecipeCategories());
                            context.read<NavigationBloc>().add(NavigateToAdminHomeRecipeCategories());
                          }
                          case 2: {
                            context.read<IngredientsBloc>().add(LoadIngredientCategories());
                            context.read<IngredientsBloc>().add(LoadIngredients());
                            context.read<NavigationBloc>().add(NavigateToAdminHomeIngredients());
                          }
                          case 3: {
                            context.read<ToolsBloc>().add(LoadToolCategories());
                            context.read<ToolsBloc>().add(LoadTools());
                            context.read<NavigationBloc>().add(NavigateToAdminHomeTools());
                          }
                          case 4: {
                            context.read<AdminStatisticsBloc>().add(LoadPromosStatistics());
                            context.read<AdminStatisticsBloc>().add(LoadTeacherStatistics());
                            context.read<AdminStatisticsBloc>().add(LoadRecipesStatistics());
                            context.read<AdminStatisticsBloc>().add(LoadIngredientsStatistics());
                            context.read<NavigationBloc>().add(NavigateToAdminHomeStatistics());
                          }
                          default: {
                            context.read<NavigationBloc>().add(NavigateToAdminHomeProfileInfo());
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
                      0 => const AdminProfilePage(),
                      1 => const AdminRecipeCategoriesPage(),
                      2 => const AdminIngredientsPage(),
                      3 => const AdminToolsPage(),
                      4 => const AdminStatisticsPage(),
                      _ => const AdminProfilePage()
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
