part of 'recipe_categories_bloc.dart';

@immutable
sealed class RecipeCategoriesEvent {}

final class LoadRecipeCategories extends RecipeCategoriesEvent {}

final class SetNewCategoryName extends RecipeCategoriesEvent {
  final String name;

  SetNewCategoryName({required this.name});
}

final class SaveNewCategory extends RecipeCategoriesEvent {
  final String name;

  SaveNewCategory({required this.name});
}
