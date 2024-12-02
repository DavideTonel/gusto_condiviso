import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe_creation/recipe_creation_bloc.dart';

import 'package:gusto_condiviso/model/recipe/recipe.dart';

class RecipeCreationPage extends StatefulWidget {
  const RecipeCreationPage({super.key});

  @override
  RecipeCreationPageState createState() => RecipeCreationPageState();
}

class RecipeCreationPageState extends State<RecipeCreationPage> {
  final recipeNameTextController = TextEditingController();
  final recipeDescriptionTextController = TextEditingController();
  final revisitedRecipeId = TextEditingController();

  @override
  void dispose() {
    recipeNameTextController.dispose();
    recipeDescriptionTextController.dispose();
    revisitedRecipeId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<RecipeCreationBloc, RecipeCreationState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Creazione Ricetta",
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
                  controller: recipeNameTextController,
                  onChanged: (value) {
                    context.read<RecipeCreationBloc>().add(SetRecipeNameEvent(name: recipeNameTextController.text));
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome ricetta"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: recipeDescriptionTextController,
                  onChanged: (value) {
                    context.read<RecipeCreationBloc>().add(SetRecipeDescriptionEvent(description: recipeDescriptionTextController.text));
                  },
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descrizione"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<RecipeCategory>(
                              //value: state.currentCategories.last,
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.3
                              ),
                              onChanged: (value) => context
                                .read<RecipeCreationBloc>()
                                .add(SelectCurrentCategory(category: value!)),
                              hint: const Text("Seleziona categorie"),
                              items: state.availableCategories
                                .map((elem) => DropdownMenuItem(
                                  value: elem,
                                  child: Text(elem.name)
                                ))
                                .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                color: Colors.amber,
                height: size.height * 0.15,
                child: ListView(
                  children: state.currentCategories.map((elem) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    child: Text(elem.name),
                  )).toList(),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  onChanged: ((value) {
                    context.read<RecipeCreationBloc>().add(SetRecipeIdIfExistsRequest(id: revisitedRecipeId.text));
                  }),
                  controller: revisitedRecipeId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Codice ricetta (se rivisitazione)"
                  ),
                ),
              ),

              if (state.revisitedRecipeId != null)
              SizedBox(
                height: size.height * 0.01,
              ),

              if (state.revisitedRecipeId != null)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text("Ricetta salvata come rivisitazione")
                  ]
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
                          state.recipeName != null && state.recipeName!.isNotEmpty &&
                          state.recipeDescription != null && state.recipeDescription!.isNotEmpty &&
                          state.currentCategories.isNotEmpty
                        ) {
                          final router = GoRouter.of(context);
                          router.push("/recipeCreation/recipeStepCreation");  
                        }
                      },
                      child: const Text(
                        "Avanti",
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
