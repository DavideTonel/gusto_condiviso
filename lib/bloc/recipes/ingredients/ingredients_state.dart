part of 'ingredients_bloc.dart';

@immutable
sealed class IngredientsState {
  final List<IngredientCategory> availableCategories;
  final List<IngredientInfo> availableIngredients;

  const IngredientsState(
    {
      required this.availableCategories,
      required this.availableIngredients,
    }
  );
  //final String? newCategoryName;
  //final String? newIngredientNameTextController;
}

final class IngredientsInitial extends IngredientsState {
  const IngredientsInitial(
    {
      super.availableCategories = const [],
      super.availableIngredients = const [],
    }
  );
}

final class IngredientsLoaded extends IngredientsState {
  const IngredientsLoaded(
    {
      required super.availableCategories,
      required super.availableIngredients,
    }
  );
}
