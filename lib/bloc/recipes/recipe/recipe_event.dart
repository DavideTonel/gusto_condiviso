part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

final class LoadRecipeRequest extends RecipeEvent {
  final int recipeId;

  LoadRecipeRequest({required this.recipeId});
}

final class LoadRecipeReviewsRequest extends RecipeEvent {
  final int recipeId;

  LoadRecipeReviewsRequest({required this.recipeId});
}

final class SetReviewScore extends RecipeEvent {
  final int score;

  SetReviewScore({required this.score});
}

final class SetReviewDescription extends RecipeEvent {
  final String description;

  SetReviewDescription({required this.description});
}

final class SaveReviewRequest extends RecipeEvent {
  final String usernameReviewCreator;

  SaveReviewRequest({required this.usernameReviewCreator});
}

final class ClearReviewCreation extends RecipeEvent {}

final class ClearRecipe extends RecipeEvent {}

final class DeleteRecipe extends RecipeEvent {}
