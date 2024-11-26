part of 'feed_recipes_bloc.dart';

@immutable
sealed class FeedRecipesState {
  final List<RecipePreview> userRecipes;
  final List<RecipePreview> savedRecipes;

  const FeedRecipesState({required this.userRecipes, required this.savedRecipes});
}

final class FeedRecipesInitial extends FeedRecipesState {
  const FeedRecipesInitial(
    {
      super.userRecipes = const [],
      super.savedRecipes = const []
    }
  );
}

final class FeedRecipesLoaded extends FeedRecipesState {
  const FeedRecipesLoaded({required super.userRecipes, required super.savedRecipes});
}
