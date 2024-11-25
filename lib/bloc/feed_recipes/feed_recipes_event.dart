part of 'feed_recipes_bloc.dart';

@immutable
sealed class FeedRecipesEvent {}

final class LoadRecipesMadeByUserRequest extends FeedRecipesEvent {
  final String username;

  LoadRecipesMadeByUserRequest({required this.username});
}

final class LoadRecipesSavedByUserRequest extends FeedRecipesEvent {
  final String username;

  LoadRecipesSavedByUserRequest({required this.username});
}

final class ToggleFavoriteRecipe extends FeedRecipesEvent {
  final int recipeId;
  final String username;

  ToggleFavoriteRecipe({required this.recipeId, required this.username});
}
