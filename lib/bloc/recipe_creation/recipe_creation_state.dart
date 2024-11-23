part of 'recipe_creation_bloc.dart';

@immutable
sealed class RecipeCreationState {
  // Recipe
  final String? recipeName;
  final String? recipeDescription;
  //final String? revisitedRecipeId;
  
  // Steps
  final List<RecipeStep> savedSteps;

  final String currentStepDescription;

  final Ingredient? currentIngredientSelected;
  final Tool? currentToolSelected;

  final List<Ingredient> availableIngredients;
  final List<Tool> availableTools;
  final List<RecipeCategory> availableCategories;

  final List<IngredientInStep> currentIngredients;
  final List<Tool> currentTools;
  final List<RecipeCategory> currentCategories;

  const RecipeCreationState(
    {
      this.recipeName,
      this.recipeDescription,
      //this.revisitedRecipeId,

      required this.savedSteps,

      required this.availableIngredients,
      required this.availableTools,
      required this.availableCategories,

      required this.currentIngredients,
      required this.currentTools,
      required this.currentCategories,
      required this.currentStepDescription,

      this.currentIngredientSelected,
      this.currentToolSelected
    }
  );
}

final class RecipeCreationInitial extends RecipeCreationState {
  const RecipeCreationInitial(
    {
      super.savedSteps = const [],
      super.availableIngredients = const [],
      super.availableTools = const [],
      super.availableCategories = const [],
      super.currentIngredients = const [],
      super.currentTools = const [],
      super.currentCategories = const [],
      super.currentStepDescription = ""
    }
  );
}

final class RecipeCreationInProgress extends RecipeCreationState {
  const RecipeCreationInProgress(
    {
      required super.savedSteps,
      required super.availableIngredients,
      required super.availableTools,
      required super.availableCategories,
      required super.currentIngredients,
      required super.currentTools,
      required super.currentCategories,
      super.currentStepDescription = "",
      super.currentIngredientSelected,
      super.currentToolSelected,
      super.recipeName,
      super.recipeDescription,
      //super.revisitedRecipeId
    }
  );
}
