part of 'admin_statistics_bloc.dart';

@immutable
sealed class AdminStatisticsEvent {}

final class LoadRecipesStatistics extends AdminStatisticsEvent {}

final class SetRecipeStatisticsType extends AdminStatisticsEvent {
  final RecipeStatisticsType type;

  SetRecipeStatisticsType({required this.type});
}

final class LoadIngredientsStatistics extends AdminStatisticsEvent {}

final class LoadTeacherStatistics extends AdminStatisticsEvent {}

final class LoadPromosStatistics extends AdminStatisticsEvent {}
