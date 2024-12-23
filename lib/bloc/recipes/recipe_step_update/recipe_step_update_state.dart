part of 'recipe_step_update_bloc.dart';

@immutable
sealed class RecipeStepUpdateState {
  final int? currentStepNumber;
  final String currentStepDescription;
  final Ingredient? currentIngredientSelected;
  final Tool? currentToolSelected;

  final List<Ingredient> availableIngredients;
  final List<Tool> availableTools;

  final List<IngredientInStep> currentIngredients;
  final List<Tool> currentTools;

  const RecipeStepUpdateState(
    {
      required this.availableIngredients,
      required this.availableTools,
      required this.currentIngredients,
      required this.currentTools,
      required this.currentStepNumber,
      required this.currentStepDescription,
      this.currentIngredientSelected,
      this.currentToolSelected
    }
  );
}

final class RecipeStepUpdateInitial extends RecipeStepUpdateState {
  const RecipeStepUpdateInitial(
    {
      super.availableIngredients = const [],
      super.availableTools = const [],
      super.currentIngredients = const [],
      super.currentTools = const [],
      super.currentStepDescription = "",
      super.currentStepNumber
    }
  );
}

final class RecipeStepUpdateInProgress extends RecipeStepUpdateState {
  const RecipeStepUpdateInProgress(
    {
      required super.availableIngredients,
      required super.availableTools,
      required super.currentIngredients,
      required super.currentTools,
      super.currentStepDescription = "",
      super.currentStepNumber,
      super.currentIngredientSelected,
      super.currentToolSelected,
    }
  );
}
