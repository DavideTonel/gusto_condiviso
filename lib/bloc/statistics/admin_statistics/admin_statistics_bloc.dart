import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/statistics/ingredient_statistics.dart';
import 'package:gusto_condiviso/model/statistics/promo_statistics.dart';
import 'package:gusto_condiviso/model/statistics/recipe_preview_statistics.dart';
import 'package:gusto_condiviso/model/statistics/recipe_statistics_type.dart';
import 'package:gusto_condiviso/model/statistics/teacher_statistics.dart';
import 'package:meta/meta.dart';

part 'admin_statistics_event.dart';
part 'admin_statistics_state.dart';

class AdminStatisticsBloc extends Bloc<AdminStatisticsEvent, AdminStatisticsState> {
  AdminStatisticsBloc() : super(const AdminStatisticsInitial()) {
    on<SetRecipeStatisticsType>((event, emit) {
      emit(
        AdminStatisticsLoaded(
          recipes: state.recipes,
          recipeStatisticsType: event.type,
          ingredients: state.ingredients,
          teacherStatistics: state.teacherStatistics,
          promos: state.promos
        )
      );
    });

    on<LoadRecipesStatistics>(onLoadRecipesStatistics);

    on<LoadIngredientsStatistics>(onLoadIngredientsStatistics);

    on<LoadTeacherStatistics>(onLoadTeacherStatistics);

    on<LoadPromosStatistics>(onLoadPromosStatistics);
  }

  FutureOr<void> onLoadRecipesStatistics(
    LoadRecipesStatistics event,
    Emitter<AdminStatisticsState> emit
  ) async {
    try {
      final client = DioClient();
      switch (state.recipeStatisticsType) {
        case RecipeStatisticsType.bySaved:
          await client.dio.post(
            "api/statistics/recipes/recipesSavedRank"
          ).then((value) {
            List<RecipePreviewStatistics> recipes = [];
            for(dynamic entry in value.data) {
              recipes.add(
                RecipePreviewStatistics(
                  id: entry["Codice"] as int,
                  name: entry["Nome"] as String,
                  usernameCreator: entry["UsernameUtente"] as String,
                  statisticsScore: entry["NumeroSalvataggi"] as int
                )
              );
            }
            emit(
              AdminStatisticsLoaded(
                recipes: recipes,
                recipeStatisticsType: state.recipeStatisticsType,
                ingredients: state.ingredients,
                teacherStatistics: state.teacherStatistics,
                promos: state.promos
              )
            );
          });
          break;

        case RecipeStatisticsType.byReviews:
          await client.dio.post(
            "api/statistics/recipes/recipesReviewsRank"
          ).then((value) {
            List<RecipePreviewStatistics> recipes = [];
            for(dynamic entry in value.data) {
              recipes.add(
                RecipePreviewStatistics(
                  id: entry["Codice"] as int,
                  name: entry["Nome"] as String,
                  usernameCreator: entry["UsernameUtente"] as String,
                  statisticsScore: entry["NumeroRecensioni"] as int
                )
              );
            }
            emit(
              AdminStatisticsLoaded(
                recipes: recipes,
                recipeStatisticsType: state.recipeStatisticsType,
                ingredients: state.ingredients,
                teacherStatistics: state.teacherStatistics,
                promos: state.promos
              )
            );
          });
          break;

        case RecipeStatisticsType.bySavedAndReviews:
          await client.dio.post(
            "api/statistics/recipes/recipesSavedAndReviewsRank"
          ).then((value) {
            List<RecipePreviewStatistics> recipes = [];
            for(dynamic entry in value.data) {
              recipes.add(
                RecipePreviewStatistics(
                  id: entry["Codice"] as int,
                  name: entry["Nome"] as String,
                  usernameCreator: entry["UsernameUtente"] as String,
                  statisticsScore: entry["Punteggio"] as int
                )
              );
            }
            emit(
              AdminStatisticsLoaded(
                recipes: recipes,
                recipeStatisticsType: state.recipeStatisticsType,
                ingredients: state.ingredients,
                teacherStatistics: state.teacherStatistics,
                promos: state.promos
              )
            );
          });
          break;
        default:
      }
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadIngredientsStatistics(
    LoadIngredientsStatistics event,
    Emitter<AdminStatisticsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/statistics/ingredient/mostUsedIngredients"
      ).then((value) {
        List<IngredientStatistics> ingredients = [];
        for (dynamic entry in value.data) {
          ingredients.add(
            IngredientStatistics(
              name: entry["Nome"] as String,
              count: entry["NumeroUtilizzi"] as int
            )
          );
        }
        emit(
          AdminStatisticsLoaded(
            recipes: state.recipes,
            recipeStatisticsType: state.recipeStatisticsType,
            ingredients: ingredients,
            teacherStatistics: state.teacherStatistics,
            promos: state.promos
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadTeacherStatistics(
    LoadTeacherStatistics event,
    Emitter<AdminStatisticsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/statistics/teacher/mostViewedTeacher"
      ).then((value) {
        emit(
          AdminStatisticsLoaded(
            recipes: state.recipes,
            recipeStatisticsType: state.recipeStatisticsType,
            ingredients: state.ingredients,
            teacherStatistics: TeacherStatistics(
              username: value.data[0]["UsernameInsegnante"] as String,
              count: value.data[0]["NumeroVideolezioniRiprodotte"] as int
            ),
            promos: state.promos
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadPromosStatistics(
    LoadPromosStatistics event,
    Emitter<AdminStatisticsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/statistics/promo/generalStatistics"
      ).then((value) {
        List<PromoStatistics> promos = [];
        for (dynamic entry in value.data) {
          promos.add(
            PromoStatistics(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              numCodeUsed: entry["NumeroCodiciUtilizzati"] as int
            )
          );
        }
        emit(
          AdminStatisticsLoaded(
            recipes: state.recipes,
            recipeStatisticsType: state.recipeStatisticsType,
            ingredients: state.ingredients,
            teacherStatistics: state.teacherStatistics,
            promos: promos
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
