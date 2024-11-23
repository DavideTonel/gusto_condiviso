import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:meta/meta.dart';

part 'recipe_creation_event.dart';
part 'recipe_creation_state.dart';

class RecipeCreationBloc extends Bloc<RecipeCreationEvent, RecipeCreationState> {
  RecipeCreationBloc() : super(const RecipeCreationInitial()) {

    // Loaders

    on<LoadAvailableIngredientsRequest>(onLoadAvailableIngredientsRequest);

    on<LoadAvailableToolsRequest>(onLoadAvailableToolsRequest);

    on<LoadAvailableCategoriesRequest>(onLoadAvailableCategoriesRequest);

    // Setters
    on<SetRecipeNameEvent>((event, emit) {
      emit(
        RecipeCreationInProgress(
          recipeName: event.name,
          recipeDescription: state.recipeDescription,
          savedSteps: state.savedSteps,
          currentStepDescription: state.currentStepDescription,
          currentIngredientSelected: state.currentIngredientSelected,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: state.currentIngredients,
          currentCategories: state.currentCategories,
          currentTools: state.currentTools,
        )
      );
    });

    on<SetRecipeDescriptionEvent>((event, emit) {
      emit(
        RecipeCreationInProgress(
          recipeName: state.recipeName,
          recipeDescription: event.description,
          savedSteps: state.savedSteps,
          currentStepDescription: state.currentStepDescription,
          currentIngredientSelected: state.currentIngredientSelected,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: state.currentIngredients,
          currentCategories: state.currentCategories,
          currentTools: state.currentTools
        )
      );
    });

    on<SelectCurrentCategory>((event, emit) {
      var newCategoriesSelected = [...state.currentCategories];
      if (newCategoriesSelected.contains(event.category)) {
        newCategoriesSelected.remove(event.category);
      } else {
        newCategoriesSelected.add(event.category);
      }

      emit(
        RecipeCreationInProgress(
          recipeName: state.recipeName,
          recipeDescription: state.recipeDescription,
          savedSteps: state.savedSteps,
          currentIngredientSelected: state.currentIngredientSelected,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentCategories: newCategoriesSelected,
          currentStepDescription: state.currentStepDescription
        )
      );
    });

    on<SetDescriptionInCurrentStepEvent>((event, emit) {
      emit(
        RecipeCreationInProgress(
          recipeName: state.recipeName,
          recipeDescription: state.recipeDescription,
          savedSteps: state.savedSteps,
          currentIngredientSelected: state.currentIngredientSelected,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentCategories: state.currentCategories,
          currentStepDescription: event.description
        )
      );
    });

    on<SetCurrentIngredientSelectedEvent>((event, emit) {
      emit(
        RecipeCreationInProgress(
          recipeName: state.recipeName,
          recipeDescription: state.recipeDescription,
          savedSteps: state.savedSteps,
          currentStepDescription: state.currentStepDescription,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentCategories: state.currentCategories,
          currentIngredientSelected: event.ingredient//Ingredient(name: event.ingredientId)
        )
      );
    });

    on<SetCurrentToolSelectedEvent>((event, emit) {
      emit(
        RecipeCreationInProgress(
          recipeName: state.recipeName,
          recipeDescription: state.recipeDescription,
          savedSteps: state.savedSteps,
          currentStepDescription: state.currentStepDescription,
          currentIngredientSelected: state.currentIngredientSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentCategories: state.currentCategories,
          currentToolSelected: event.tool
        )
      );
    });

    // Savers

    on<SaveIngredientInCurrentStepEvent>((event, emit) {
      final newCurrentIngredients = [
        ...state.currentIngredients,
        IngredientInStep(
          ingredient: state.currentIngredientSelected!,
          amount: event.amount
        )
      ];

      emit(
        RecipeCreationInProgress(
          recipeName: state.recipeName,
          recipeDescription: state.recipeDescription,
          savedSteps: state.savedSteps,
          currentStepDescription: state.currentStepDescription,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: newCurrentIngredients,
          currentTools: state.currentTools,
          currentCategories: state.currentCategories,
          currentIngredientSelected: null
        )
      );
    });

    on<SaveToolInCurrentStepEvent>((event, emit) {
      final newCurrentTools = [
        ...state.currentTools,
        state.currentToolSelected!
      ];

      emit(
        RecipeCreationInProgress(
          recipeName: state.recipeName,
          recipeDescription: state.recipeDescription,
          savedSteps: state.savedSteps,
          currentStepDescription: state.currentStepDescription,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: state.currentIngredients,
          currentTools: newCurrentTools,
          currentCategories: state.currentCategories,
          currentIngredientSelected: null
        )
      );
    });

    on<SaveRecipeStepEvent>((event, emit) {
      final step = RecipeStep(
        description: state.currentStepDescription,
        ingredients: state.currentIngredients,
        tools: state.currentTools
      );

      final newSavedSteps = [
        ...state.savedSteps,
        step
      ];
      emit(RecipeCreationInProgress(
          recipeName: state.recipeName,
          recipeDescription: state.recipeDescription,
          savedSteps: newSavedSteps,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          availableCategories: state.availableCategories,
          currentIngredients: const [],
          currentTools: const [],
          currentCategories: state.currentCategories,
          currentStepDescription: "",
          currentIngredientSelected: null,
          currentToolSelected: null
        )
      );
    });

    on<SaveRecipeRequest>(onSaveRecipeRequest);
  }

  FutureOr<void> onLoadAvailableIngredientsRequest(
    LoadAvailableIngredientsRequest event,
    Emitter<RecipeCreationState> emit
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
            RecipeCreationInProgress(
              recipeName: state.recipeName,
              recipeDescription: state.recipeDescription,
              savedSteps: state.savedSteps,
              currentStepDescription: state.currentStepDescription,
              currentIngredientSelected: state.currentIngredientSelected,
              currentToolSelected: state.currentToolSelected,
              availableIngredients: ingredients,
              availableTools: state.availableTools,
              availableCategories: state.availableCategories,
              currentIngredients: state.currentIngredients,
              currentTools: state.currentTools,
              currentCategories: state.currentCategories
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadAvailableToolsRequest(
    LoadAvailableToolsRequest event,
    Emitter<RecipeCreationState> emit
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
            RecipeCreationInProgress(
              recipeName: state.recipeName,
              recipeDescription: state.recipeDescription,
              savedSteps: state.savedSteps,
              currentStepDescription: state.currentStepDescription,
              currentIngredientSelected: state.currentIngredientSelected,
              currentToolSelected: state.currentToolSelected,
              availableIngredients: state.availableIngredients,
              availableTools: tools,
              availableCategories: state.availableCategories,
              currentIngredients: state.currentIngredients,
              currentTools: state.currentTools,
              currentCategories: state.currentCategories
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadAvailableCategoriesRequest(
    LoadAvailableCategoriesRequest event,
    Emitter<RecipeCreationState> emit
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
            RecipeCreationInProgress(
              recipeName: state.recipeName,
              recipeDescription: state.recipeDescription,
              savedSteps: state.savedSteps,
              currentStepDescription: state.currentStepDescription,
              currentIngredientSelected: state.currentIngredientSelected,
              currentToolSelected: state.currentToolSelected,
              availableIngredients: state.availableIngredients,
              availableTools: state.availableTools,
              availableCategories: categories,
              currentIngredients: state.currentIngredients,
              currentTools: state.currentTools,
              currentCategories: state.currentCategories
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveRecipeRequest(
    SaveRecipeRequest event,
    Emitter<RecipeCreationState> emit
  ) async {
    //dev.log("Save recipe request");
    var steps = [...state.savedSteps];
    var categories = [...state.currentCategories];

    var jsonSteps = jsonEncode(steps.map((step) => step.toJson()).toList());
    var jsonCategories = jsonEncode(categories.map((cat) => cat.toJson()).toList());

    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveRecipe",
        data: {
          "creatorId": event.creatorId,
          "recipeName": state.recipeName,
          "recipeDescription": state.recipeDescription,
          "categories": jsonCategories,
          "steps": jsonSteps,
        }
      ).then((value) {
        
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
