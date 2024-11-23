part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

final class LoadRecipeRequest extends RecipeEvent {
  final int recipeId;

  LoadRecipeRequest({required this.recipeId});
}
