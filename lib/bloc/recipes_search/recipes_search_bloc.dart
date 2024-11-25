import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:gusto_condiviso/model/recipe/search/recipe_search_type.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as dev;

part 'recipes_search_event.dart';
part 'recipes_search_state.dart';

class RecipesSearchBloc extends Bloc<RecipesSearchEvent, RecipesSearchState> {
  RecipesSearchBloc() : super(const RecipesSearchInitial()) {

    // Loaders

    on<LoadAvailableCategoriesForSearchRequest>(onLoadAvailableCategoriesForSearchRequest);

    on<LoadAvailableIngredientsForSearchRequest>(onLoadAvailableIngredientsForSearchRequest);

    on<LoadAvailableToolsForSearchRequest>(onLoadAvailableToolsForSearchRequest);

    // Setters

    on<SetRecipeIdEvent>((event, emit) {
      try {
        emit(
          RecipeSearchInProgress(
            selectedCategories: state.selectedCategories,
            selectedIngredients: state.selectedIngredients,
            selectedTools: state.selectedTools,
            availableCategories: state.availableCategories,
            availableIngredients: state.availableIngredients,
            availableTools: state.availableTools,
            recipeId: int.parse(event.id),
            recipeName: state.recipeName,
            results: state.results,
            searchType: state.searchType
          )
        );
      } catch (e) {
        dev.log(e.toString());
      }
    });

    on<SetRecipeNameEvent>((event, emit) {
      emit(
        RecipeSearchInProgress(
          selectedCategories: state.selectedCategories,
          selectedIngredients: state.selectedIngredients,
          selectedTools: state.selectedTools,
          availableCategories: state.availableCategories,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          recipeId: state.recipeId,
          recipeName: event.name,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SelectRecipeCategory>((event, emit) {
      var newCategoriesSelected = [...state.selectedCategories];
      if (newCategoriesSelected.contains(event.category)) {
        newCategoriesSelected.remove(event.category);
      } else {
        newCategoriesSelected.add(event.category);
      }

      emit(
        RecipeSearchInProgress(
          selectedCategories: newCategoriesSelected,
          selectedIngredients: state.selectedIngredients,
          selectedTools: state.selectedTools,
          availableCategories: state.availableCategories,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          recipeId: state.recipeId,
          recipeName: state.recipeName,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SelectRecipeIngredient>((event, emit) {
      var newIngredientsSelected = [...state.selectedIngredients];
      if (newIngredientsSelected.contains(event.ingredient)) {
        newIngredientsSelected.remove(event.ingredient);
      } else {
        newIngredientsSelected.add(event.ingredient);
      }

      emit(
        RecipeSearchInProgress(
          selectedCategories: state.selectedCategories,
          selectedIngredients: newIngredientsSelected,
          selectedTools: state.selectedTools,
          availableCategories: state.availableCategories,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          recipeId: state.recipeId,
          recipeName: state.recipeName,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SelectRecipeTool>((event, emit) {
      var newToolsSelected = [...state.selectedTools];
      if (newToolsSelected.contains(event.tool)) {
        newToolsSelected.remove(event.tool);
      } else {
        newToolsSelected.add(event.tool);
      }

      emit(
        RecipeSearchInProgress(
          selectedCategories: state.selectedCategories,
          selectedIngredients: state.selectedIngredients,
          selectedTools: newToolsSelected,
          availableCategories: state.availableCategories,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          recipeId: state.recipeId,
          recipeName: state.recipeName,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SetRecipeSearchType>((event, emit) {
      emit(
        RecipeSearchInProgress(
          selectedCategories: state.selectedCategories,
          selectedIngredients: state.selectedIngredients,
          selectedTools: state.selectedTools,
          availableCategories: state.availableCategories,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          recipeId: state.recipeId,
          recipeName: state.recipeName,
          results: state.results,
          searchType: event.type
        )
      );
    });

    // Search
  
    on<SearchRequest>(onSearchRequest);

    on<ClearSearch>((event, emit) {
      emit(
        RecipeSearchInProgress(
          selectedCategories: const [],
          selectedIngredients: const [],
          selectedTools: const [],
          availableCategories: state.availableCategories,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          recipeId: state.recipeId,
          recipeName: state.recipeName,
          results: const [],
          searchType: state.searchType)
      );
    });
  }

  FutureOr<void> onLoadAvailableCategoriesForSearchRequest(
    LoadAvailableCategoriesForSearchRequest event,
    Emitter<RecipesSearchState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/recipeCategories"
      ).then((value) {
        List<RecipeCategory> categories = [];
        for(dynamic entry in value.data) {
          categories.add(
            RecipeCategory(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String
            )
          );
          emit(
            RecipeSearchInProgress(
              recipeId: state.recipeId,
              recipeName: state.recipeName,
              availableIngredients: state.availableIngredients,
              availableTools: state.availableTools,
              availableCategories: categories,
              selectedIngredients: state.selectedIngredients,
              selectedTools: state.selectedTools,
              selectedCategories: state.selectedCategories,
              results: state.results,
              searchType: state.searchType
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadAvailableIngredientsForSearchRequest(
    LoadAvailableIngredientsForSearchRequest event,
    Emitter<RecipesSearchState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/ingredients"
      ).then((value) {
        List<Ingredient> ingredients = [];
        for(dynamic entry in value.data) {
          ingredients.add(
            Ingredient(
              name: entry["Nome"] as String
            )
          );
          emit(
            RecipeSearchInProgress(
              recipeId: state.recipeId,
              recipeName: state.recipeName,
              availableIngredients: ingredients,
              availableTools: state.availableTools,
              availableCategories: state.availableCategories,
              selectedIngredients: state.selectedIngredients,
              selectedTools: state.selectedTools,
              selectedCategories: state.selectedCategories,
              results: state.results,
              searchType: state.searchType
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadAvailableToolsForSearchRequest(
    LoadAvailableToolsForSearchRequest event,
    Emitter<RecipesSearchState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/tools"
      ).then((value) {
        List<Tool> tools = [];
        for(dynamic entry in value.data) {
          tools.add(
            Tool(
              name: entry["Nome"] as String
            )
          );
          emit(
            RecipeSearchInProgress(
              recipeId: state.recipeId,
              recipeName: state.recipeName,
              availableIngredients: state.availableIngredients,
              availableTools: tools,
              availableCategories: state.availableCategories,
              selectedIngredients: state.selectedIngredients,
              selectedTools: state.selectedTools,
              selectedCategories: state.selectedCategories,
              results: state.results,
              searchType: state.searchType
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSearchRequest(
    SearchRequest event,
    Emitter<RecipesSearchState> emit
  ) async {
    var categories = [...state.selectedCategories];
    var jsonCategories = jsonEncode(categories.map((cat) => cat.toJson()).toList());

    var ingredients = [...state.selectedIngredients];
    var jsonIngredients = jsonEncode(ingredients.map((i) => i.toJson()).toList());

    var tools = [...state.selectedTools];
    var jsonTools = jsonEncode(tools.map((t) => t.toJson()).toList());


    try {
      var client = DioClient();
      await client.dio.post(
        "api/searchRecipes",
        data: {
          "id": state.recipeId,
          "name": state.recipeName,
          "searchType": state.searchType.name,
          "categories": jsonCategories,
          "ingredients": jsonIngredients,
          "tools": jsonTools
        }
      ).then((value) {
        List<RecipePreview> recipes = [];
        for(dynamic entry in value.data) {
          recipes.add(
            RecipePreview(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              usernameCreator: entry["UsernameUtente"] as String
            )
          );
          emit(
            RecipeSearchInProgress(
              recipeId: state.recipeId,
              recipeName: state.recipeName,
              availableIngredients: state.availableIngredients,
              availableTools: state.availableTools,
              availableCategories: state.availableCategories,
              selectedIngredients: state.selectedIngredients,
              selectedTools: state.selectedTools,
              selectedCategories: state.selectedCategories,
              results: recipes,
              searchType: state.searchType
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
