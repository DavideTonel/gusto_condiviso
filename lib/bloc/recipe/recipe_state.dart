part of 'recipe_bloc.dart';

@immutable
sealed class RecipeState {
  final Recipe? recipe;
  final List<RecipeReview> reviews;

  final int? currentReviewScore;
  final String? currentReviewDescription;

  const RecipeState(
    {
      required this.recipe,
      required this.reviews,
      this.currentReviewScore,
      this.currentReviewDescription
    }
  );
}

final class RecipeInitial extends RecipeState {
  const RecipeInitial(
    {
      super.recipe,
      super.reviews = const [],
    }
  );
}

final class RecipeLoaded extends RecipeState {
  const RecipeLoaded(
    {
      required super.recipe,
      required super.reviews,
      super.currentReviewScore,
      super.currentReviewDescription
    }
  );
}
