/*
part of 'recipe_step_update_bloc.dart';

@immutable
sealed class RecipeStepUpdateEvent {}

// Loaders

final class LoadRecipeStep extends RecipeStepUpdateEvent {
  final int recipeId;
  final int stepNumber;

  LoadRecipeStep({required this.recipeId, required this.stepNumber});
}

final class LoadAvailableIngredientsRequest extends RecipeStepUpdateEvent {}

final class LoadAvailableToolsRequest extends RecipeStepUpdateEvent {}

// Step setters

final class SelectCurrentCategory extends RecipeStepUpdateEvent {
  final RecipeCategory category;

  SelectCurrentCategory({required this.category});
}

final class SetDescriptionInCurrentStepEvent extends RecipeStepUpdateEvent {
  final String description;

  SetDescriptionInCurrentStepEvent({required this.description});
}

final class SetCurrentToolSelectedEvent extends RecipeStepUpdateEvent {
  final Tool tool;

  SetCurrentToolSelectedEvent({required this.tool});
}

final class SetCurrentIngredientSelectedEvent extends RecipeStepUpdateEvent {
  final Ingredient ingredient;

  SetCurrentIngredientSelectedEvent({required this.ingredient});
}

// Savers

final class SaveIngredientInCurrentStepEvent extends RecipeStepUpdateEvent {
  final String amount;

  SaveIngredientInCurrentStepEvent({required this.amount});
}

final class SaveToolInCurrentStepEvent extends RecipeStepUpdateEvent {}

final class UpdateRecipeStepEvent extends RecipeStepUpdateEvent {
  final int recipeId;
  final int stepNumber;

  UpdateRecipeStepEvent({required this.recipeId, required this.stepNumber});
}

final class ClearRecipeStep extends RecipeStepUpdateEvent {}
*/

part of 'recipe_step_update_bloc.dart';

@immutable
sealed class RecipeStepUpdateEvent {}

// Loaders

final class LoadRecipeStep extends RecipeStepUpdateEvent {
  final int recipeId;
  final int stepNumber;

  LoadRecipeStep({required this.recipeId, required this.stepNumber});
}

final class LoadAvailableIngredientsRequest extends RecipeStepUpdateEvent {}

final class LoadAvailableToolsRequest extends RecipeStepUpdateEvent {}

// Step setters

final class SelectCurrentCategory extends RecipeStepUpdateEvent {
  final RecipeCategory category;

  SelectCurrentCategory({required this.category});
}

final class SetDescriptionInCurrentStepEvent extends RecipeStepUpdateEvent {
  final String description;

  SetDescriptionInCurrentStepEvent({required this.description});
}

final class SetCurrentToolSelectedEvent extends RecipeStepUpdateEvent {
  final Tool tool;

  SetCurrentToolSelectedEvent({required this.tool});
}

final class SetCurrentIngredientSelectedEvent extends RecipeStepUpdateEvent {
  final Ingredient ingredient;

  SetCurrentIngredientSelectedEvent({required this.ingredient});
}

// Savers

final class SaveIngredientInCurrentStepEvent extends RecipeStepUpdateEvent {
  final String ingredientName;
  final String amount;
  final int recipeId;
  final int stepNumber;

  SaveIngredientInCurrentStepEvent({required this.ingredientName, required this.amount, required this.recipeId, required this.stepNumber});
}

final class RemoveIngredientInCurrentStepEvent extends RecipeStepUpdateEvent {
  final String ingredientName;
  final int recipeId;
  final int stepNumber;

  RemoveIngredientInCurrentStepEvent({required this.ingredientName, required this.recipeId, required this.stepNumber});
}

final class SaveToolInCurrentStepEvent extends RecipeStepUpdateEvent {
  final String toolName;
  final int recipeId;
  final int stepNumber;

  SaveToolInCurrentStepEvent({required this.toolName, required this.recipeId, required this.stepNumber});
}

final class RemoveToolFromCurrentStepEvent extends RecipeStepUpdateEvent {
  final String toolName;
  final int recipeId;
  final int stepNumber;

  RemoveToolFromCurrentStepEvent({required this.toolName, required this.recipeId, required this.stepNumber});
}

final class UpdateDescriptionCurrentStepEvent extends RecipeStepUpdateEvent {
  final String description;
  final int recipeId;
  final int stepNumber;

  UpdateDescriptionCurrentStepEvent({required this.description, required this.recipeId, required this.stepNumber});
}

/*
final class UpdateRecipeStepEvent extends RecipeStepUpdateEvent {
  final int recipeId;
  final int stepNumber;

  UpdateRecipeStepEvent({required this.recipeId, required this.stepNumber});
}
*/

final class ClearRecipeStep extends RecipeStepUpdateEvent {}
