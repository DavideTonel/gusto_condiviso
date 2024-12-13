part of 'ingredients_bloc.dart';

@immutable
sealed class IngredientsEvent {}

final class LoadIngredientCategories extends IngredientsEvent {}

final class LoadIngredients extends IngredientsEvent {}

//final class SetN

final class SaveIngredientCategory extends IngredientsEvent {
  final String name;

  SaveIngredientCategory({required this.name});
}

final class SaveIngredient extends IngredientsEvent {
  final String name;
  final int categoryId;

  SaveIngredient({required this.name, required this.categoryId});
}
