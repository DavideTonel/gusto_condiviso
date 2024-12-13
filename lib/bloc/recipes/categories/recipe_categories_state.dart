part of 'recipe_categories_bloc.dart';

@immutable
sealed class RecipeCategoriesState {
  final List<RecipeCategory> availableCategories;

  const RecipeCategoriesState({required this.availableCategories});
}

final class RecipeCategoriesInitial extends RecipeCategoriesState {
  const RecipeCategoriesInitial(
    {
      super.availableCategories = const [],
    }
  );
}

final class RecipeCategoriesLoaded extends RecipeCategoriesState {
  const RecipeCategoriesLoaded(
    {
      required super.availableCategories,
    }
  );
}
