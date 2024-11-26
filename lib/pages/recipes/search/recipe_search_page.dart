import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/recipes/recipes_search/recipes_search_bloc.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:gusto_condiviso/model/recipe/search/recipe_search_type.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  RecipeSearchPageState createState() => RecipeSearchPageState();
}

class RecipeSearchPageState extends State<RecipeSearchPage> {
  final recipeNameTextController = TextEditingController();
  final recipeIdTextController = TextEditingController();

  @override
  void dispose() {
    recipeIdTextController.dispose();
    recipeNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<RecipesSearchBloc, RecipesSearchState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Ricerca ricetta"),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
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
                            child: DropdownButton2<RecipeSearchType>(
                              dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3),
                              onChanged: (value) => context
                                  .read<RecipesSearchBloc>()
                                  .add(SetRecipeSearchType(type: value!)),
                              hint: const Text("Cerca per"),
                              items: RecipeSearchType.values
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

              SizedBox(
                height: size.height * 0.1,
              ),

              if (state.searchType == RecipeSearchType.byId)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: recipeIdTextController,
                  onChanged: (value) {
                    context.read<RecipesSearchBloc>().add(SetRecipeIdEvent(id: recipeIdTextController.text));
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Codice Ricetta"),
                ),
              ),

              if (state.searchType == RecipeSearchType.byId)
              SizedBox(
                height: size.height * 0.02,
              ),

              if (state.searchType == RecipeSearchType.byName || state.searchType == RecipeSearchType.byNameAndCategories)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: recipeNameTextController,
                  onChanged: (value) {
                    context.read<RecipesSearchBloc>().add(SetRecipeNameEvent(name: recipeNameTextController.text));
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Nome ricetta"),
                ),
              ),

              if (state.searchType == RecipeSearchType.byName || state.searchType == RecipeSearchType.byNameAndCategories)
              SizedBox(
                height: size.height * 0.05,
              ),

              if (state.searchType == RecipeSearchType.byCategories || state.searchType == RecipeSearchType.byNameAndCategories)
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
                              dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3),
                              onChanged: (value) => context
                                  .read<RecipesSearchBloc>()
                                  .add(SelectRecipeCategory(category: value!)),
                              hint: const Text("Seleziona categorie"),
                              items: state.availableCategories
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

              if (state.searchType == RecipeSearchType.byCategories || state.searchType == RecipeSearchType.byNameAndCategories)
              Container(
                color: Colors.amber,
                height: size.height * 0.10,
                child: ListView(
                  children: state.selectedCategories
                      .map((elem) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 2.0),
                            child: Text(elem.name),
                          ))
                      .toList(),
                ),
              ),

              if (state.searchType == RecipeSearchType.byIngredients || state.searchType == RecipeSearchType.byIngredientsAndTools)
              SizedBox(
                height: size.height * 0.05,
              ),

              if (state.searchType == RecipeSearchType.byIngredients || state.searchType == RecipeSearchType.byIngredientsAndTools)
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
                            child: DropdownButton2<Ingredient>(
                              dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3),
                              onChanged: (value) => context
                                  .read<RecipesSearchBloc>()
                                  .add(SelectRecipeIngredient(ingredient: value!)),
                              hint: const Text("Seleziona Ingredienti"),
                              items: state.availableIngredients
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

              if (state.searchType == RecipeSearchType.byIngredients || state.searchType == RecipeSearchType.byIngredientsAndTools)
              Container(
                color: Colors.amber,
                height: size.height * 0.10,
                child: ListView(
                  children: state.selectedIngredients
                      .map((elem) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 2.0),
                            child: Text(elem.name),
                          ))
                      .toList(),
                ),
              ),

              if (state.searchType == RecipeSearchType.byIngredients || state.searchType == RecipeSearchType.byIngredientsAndTools)
              SizedBox(
                height: size.height * 0.05,
              ),

              if (state.searchType == RecipeSearchType.byTools || state.searchType == RecipeSearchType.byIngredientsAndTools)
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
                            child: DropdownButton2<Tool>(
                              dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3),
                              onChanged: (value) => context
                                  .read<RecipesSearchBloc>()
                                  .add(SelectRecipeTool(tool: value!)),
                              hint: const Text("Seleziona Utensili"),
                              items: state.availableTools
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

              if (state.searchType == RecipeSearchType.byTools || state.searchType == RecipeSearchType.byIngredientsAndTools)
              Container(
                color: Colors.amber,
                height: size.height * 0.10,
                child: ListView(
                  children: state.selectedTools
                      .map((elem) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 2.0),
                            child: Text(elem.name),
                          ))
                      .toList(),
                ),
              ),
              
              //if (state.searchType == RecipeSearchType.byTools || state.searchType == RecipeSearchType.byIngredientsAndTools)
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
                          state.recipeId != null || 
                          (state.recipeName != null && state.recipeName!.isNotEmpty) ||
                          state.selectedCategories.isNotEmpty ||
                          state.selectedIngredients.isNotEmpty ||
                          state.selectedTools.isNotEmpty
                        ) {
                          context.read<RecipesSearchBloc>().add(SearchRequest());
                          final router = GoRouter.of(context);
                          router.push("/recipeSearch/results");  
                        }
                      },
                      child: const Text(
                        "Cerca",
                        style: TextStyle(fontSize: 24),
                      )
                    ),

                    SizedBox(
                      height: size.height * 0.1,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
