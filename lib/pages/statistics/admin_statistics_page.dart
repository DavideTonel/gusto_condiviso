import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/statistics/admin_statistics/admin_statistics_bloc.dart';
import 'package:gusto_condiviso/model/statistics/recipe_statistics_type.dart';

class AdminStatisticsPage extends StatelessWidget {
  const AdminStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<AdminStatisticsBloc, AdminStatisticsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
    
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Statistiche",
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ],
            ),
    
            SizedBox(
              height: size.height * 0.02,
            ),
    
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Classifica Ricetta",
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<RecipeStatisticsType>(
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3
                                ),
                                onChanged: (value) {
                                  context.read<AdminStatisticsBloc>().add(SetRecipeStatisticsType(type: value!));
                                  context.read<AdminStatisticsBloc>().add(LoadRecipesStatistics());
                                },
                                hint: const Text("Classifica per"),
                                items: RecipeStatisticsType.values
                                  .map((elem) => DropdownMenuItem(
                                    value: elem, child: Text(elem.name)))
                                  .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    
            if (state.recipeStatisticsType == RecipeStatisticsType.byReviews)
            SizedBox(
              height: size.height * 0.15,
              child: ListView(
                children: state.recipes.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    subtitle: Row(
                      children: [
                        Text("Codice: ${elem.id}"),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text("Nome: ${elem.name}")
                      ],
                    ),
                    trailing: Text("Numero recensioni: ${elem.statisticsScore}"),
                  )
                )).toList(),
              ),
            ),

            if (state.recipeStatisticsType == RecipeStatisticsType.bySaved)
            SizedBox(
              height: size.height * 0.15,
              child: ListView(
                children: state.recipes.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    subtitle: Row(
                      children: [
                        Text("Codice: ${elem.id}"),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text("Nome: ${elem.name}")
                      ],
                    ),
                    trailing: Text("Numero salvataggi: ${elem.statisticsScore}"),
                  )
                )).toList(),
              ),
            ),

            if (state.recipeStatisticsType == RecipeStatisticsType.bySavedAndReviews)
            SizedBox(
              height: size.height * 0.15,
              child: ListView(
                children: state.recipes.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    subtitle: Row(
                      children: [
                        Text("Codice: ${elem.id}"),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text("Nome: ${elem.name}")
                      ],
                    ),
                    trailing: Text("Punteggio: ${elem.statisticsScore}"),
                  )
                )).toList(),
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),
    
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Ingredienti più usati in ricette",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
    
            SizedBox(
              height: size.height * 0.15,
              child: ListView(
                children: state.ingredients.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    trailing: Text(elem.count.toString())
                  )
                )).toList(),
              ),
            ),
    
            SizedBox(
              height: size.height * 0.02,
            ),
    
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    "Insegnante con più lezioni riprodotte: ",
                    style: TextStyle(fontSize: 20),
                  ),
              
                  SizedBox(
                    width: size.width * 0.01,
                  ),
              
                  Text(
                    "${state.teacherStatistics?.username ?? "non disponibile"} con ${state.teacherStatistics?.count ?? ""} visualizzazioni",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    
    
            SizedBox(
              height: size.height * 0.02,
            ),
    
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Statistiche promozioni attive",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.02,
            ),

            SizedBox(
              height: size.height * 0.15,
              child: ListView(
                children: state.promos.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    subtitle: Text("Codice: ${elem.id}"),
                    trailing: Text("Utilizzi: ${elem.numCodeUsed}"),
                  )
                )).toList(),
              ),
            ),      
          ],
        );
      },
    );
  }

}