part of 'admin_statistics_bloc.dart';

@immutable
sealed class AdminStatisticsState {
  final List<RecipePreviewStatistics> recipes;
  final RecipeStatisticsType recipeStatisticsType;
  final List<IngredientStatistics> ingredients;
  final TeacherStatistics? teacherStatistics;
  final List<PromoStatistics> promos;

  const AdminStatisticsState({
    required this.recipes,
    required this.recipeStatisticsType,
    required this.ingredients,
    required this.teacherStatistics,
    required this.promos,
  });
}

final class AdminStatisticsInitial extends AdminStatisticsState {
  const AdminStatisticsInitial(
    {
      super.recipes = const [],
      super.recipeStatisticsType = RecipeStatisticsType.bySaved,
      super.ingredients = const [],
      super.teacherStatistics,
      super.promos = const []
    }
  );
}

final class AdminStatisticsLoaded extends AdminStatisticsState {
  const AdminStatisticsLoaded(
    {
      required super.recipes,
      required super.recipeStatisticsType,
      required super.ingredients,
      required super.teacherStatistics,
      required super.promos
    }
  );
}