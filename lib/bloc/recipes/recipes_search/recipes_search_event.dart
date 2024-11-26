part of 'recipes_search_bloc.dart';

@immutable
sealed class RecipesSearchEvent {}

// Loaders 

final class LoadAvailableCategoriesForSearchRequest extends RecipesSearchEvent {}

final class LoadAvailableIngredientsForSearchRequest extends RecipesSearchEvent {}

final class LoadAvailableToolsForSearchRequest extends RecipesSearchEvent {}

// Recipe setters

final class SetRecipeIdEvent extends RecipesSearchEvent {
  final String id;

  SetRecipeIdEvent({required this.id});
}

final class SetRecipeNameEvent extends RecipesSearchEvent {
  final String name;

  SetRecipeNameEvent({required this.name});
}

final class SelectRecipeCategory extends RecipesSearchEvent {
  final RecipeCategory category;

  SelectRecipeCategory({required this.category});
}

final class SelectRecipeIngredient extends RecipesSearchEvent {
  final Ingredient ingredient;

  SelectRecipeIngredient({required this.ingredient}); 
}

final class SelectRecipeTool extends RecipesSearchEvent {
  final Tool tool;

  SelectRecipeTool({required this.tool});
}

final class SetRecipeSearchType extends RecipesSearchEvent {
  final RecipeSearchType type;

  SetRecipeSearchType({required this.type});
}

// Search

final class SearchRequest extends RecipesSearchEvent {}

final class ClearSearch extends RecipesSearchEvent {}