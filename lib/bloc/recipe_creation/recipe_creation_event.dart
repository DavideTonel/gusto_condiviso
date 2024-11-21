part of 'recipe_creation_bloc.dart';

@immutable
sealed class RecipeCreationEvent {}

// Loaders

final class LoadAvailableIngredientsRequest extends RecipeCreationEvent {}

final class LoadAvailableToolsRequest extends RecipeCreationEvent {}

final class LoadAvailableCategoriesRequest extends RecipeCreationEvent {}

// Recipe setters

final class SetRecipeNameEvent extends RecipeCreationEvent {
  final String name;

  SetRecipeNameEvent({required this.name});
}

final class SetRecipeDescriptionEvent extends RecipeCreationEvent {
  final String description;

  SetRecipeDescriptionEvent({required this.description});
}

// Step setters

final class SelectCurrentCategory extends RecipeCreationEvent {
  final RecipeCategory category;

  SelectCurrentCategory({required this.category});
}

final class SetDescriptionInCurrentStepEvent extends RecipeCreationEvent {
  final String description;

  SetDescriptionInCurrentStepEvent({required this.description});
}

final class SetCurrentToolSelectedEvent extends RecipeCreationEvent {
  final Tool tool;

  SetCurrentToolSelectedEvent({required this.tool});
}

final class SetCurrentIngredientSelectedEvent extends RecipeCreationEvent {
  final Ingredient ingredient;

  SetCurrentIngredientSelectedEvent({required this.ingredient});
}

// Savers

final class SaveIngredientInCurrentStepEvent extends RecipeCreationEvent {
  final String amount;

  SaveIngredientInCurrentStepEvent({required this.amount});
}

final class SaveToolInCurrentStepEvent extends RecipeCreationEvent {}

final class SaveRecipeStepEvent extends RecipeCreationEvent {}

final class SaveRecipeRequest extends RecipeCreationEvent {
  final String creatorId;

  SaveRecipeRequest({required this.creatorId});
}
