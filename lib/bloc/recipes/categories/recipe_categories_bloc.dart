import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:meta/meta.dart';

part 'recipe_categories_event.dart';
part 'recipe_categories_state.dart';

class RecipeCategoriesBloc extends Bloc<RecipeCategoriesEvent, RecipeCategoriesState> {
  RecipeCategoriesBloc() : super(const RecipeCategoriesInitial()) {
    on<LoadRecipeCategories>(onLoadRecipeCategories);

    on<SetNewCategoryName>((event, emit) {
      emit(
        RecipeCategoriesLoaded(
          availableCategories: state.availableCategories,
        )
      );
    });

    on<SaveNewCategory>(onSaveNewCategory);

    on<DeleteCategory>(onDeleteCategory);
  }

  FutureOr<void> onLoadRecipeCategories(
    LoadRecipeCategories event,
    Emitter<RecipeCategoriesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/recipeCategories"
      ).then((value) {
        List<RecipeCategory> categories = [];
        for (dynamic entry in value.data) {
          categories.add(
            RecipeCategory(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String
            )
          );
        }

        emit(
          RecipeCategoriesLoaded(
            availableCategories: categories,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveNewCategory(
    SaveNewCategory event,
    Emitter<RecipeCategoriesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveRecipeCategory",
        data: {
          "name": event.name
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipeCategories"
        ).then((value) {
          List<RecipeCategory> categories = [];
          for (dynamic entry in value.data) {
            categories.add(
              RecipeCategory(
                id: entry["Codice"] as int,
                name: entry["Nome"] as String
              )
            );
          }

          emit(
            RecipeCategoriesLoaded(
              availableCategories: categories,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onDeleteCategory(
    DeleteCategory event,
    Emitter<RecipeCategoriesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/deleteRecipeCategory",
        data: {
          "id": event.id
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipeCategories"
        ).then((value) {
          List<RecipeCategory> categories = [];
          for (dynamic entry in value.data) {
            categories.add(
              RecipeCategory(
                id: entry["Codice"] as int,
                name: entry["Nome"] as String
              )
            );
          }

          emit(
            RecipeCategoriesLoaded(
              availableCategories: categories,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
