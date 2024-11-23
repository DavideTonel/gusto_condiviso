part of 'recipe_bloc.dart';

@immutable
sealed class RecipeState {
  final Recipe? recipe;

  const RecipeState({required this.recipe});
}

final class RecipeInitial extends RecipeState {
  const RecipeInitial({super.recipe});
}

final class RecipeLoaded extends RecipeState {
  const RecipeLoaded({required super.recipe});
}
