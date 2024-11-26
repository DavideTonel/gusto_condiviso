part of 'recipes_search_bloc.dart';

@immutable
sealed class RecipesSearchState {

  final int? recipeId;
  final String? recipeName;

  final List<RecipeCategory> selectedCategories;
  final List<Ingredient> selectedIngredients;
  final List<Tool> selectedTools;

  final List<RecipeCategory> availableCategories;
  final List<Ingredient> availableIngredients;
  final List<Tool> availableTools;

  final List<RecipePreview> results;

  final RecipeSearchType searchType;

  const RecipesSearchState(
    {
      this.recipeId,
      this.recipeName,
      required this.selectedCategories,
      required this.selectedIngredients,
      required this.selectedTools,
      required this.availableCategories,
      required this.availableIngredients,
      required this.availableTools,
      required this.results,
      required this.searchType
    }
  );
}

final class RecipesSearchInitial extends RecipesSearchState {
  const RecipesSearchInitial(
    {
      super.selectedCategories = const [],
      super.selectedIngredients = const [],
      super.selectedTools = const [],
      super.availableCategories = const [],
      super.availableIngredients = const [],
      super.availableTools = const [],
      super.results = const [],
      super.searchType = RecipeSearchType.byId
    }
  );
}

final class RecipeSearchInProgress extends RecipesSearchState {
  const RecipeSearchInProgress(
    {
      required super.selectedCategories,
      required super.selectedIngredients,
      required super.selectedTools,
      required super.availableCategories,
      required super.availableIngredients,
      required super.availableTools,
      required super.recipeId,
      required super.recipeName,
      required super.results,
      required super.searchType
    }
  );
}
