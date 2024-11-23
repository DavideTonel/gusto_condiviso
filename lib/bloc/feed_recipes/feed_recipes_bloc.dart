import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:meta/meta.dart';

part 'feed_recipes_event.dart';
part 'feed_recipes_state.dart';

class FeedRecipesBloc extends Bloc<FeedRecipesEvent, FeedRecipesState> {
  FeedRecipesBloc() : super(const FeedRecipesInitial()) {
    on<LoadRecipesMadeByUserRequest>(onLoadRecipesMadeByUserRequest);

    on<LoadRecipesSavedByUserRequest>(onLoadRecipesSavedByUserRequest);
  }

  FutureOr<void> onLoadRecipesMadeByUserRequest(
    LoadRecipesMadeByUserRequest event,
    Emitter<FeedRecipesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/recipesMadeByUser",
        data: {
          "username": event.username
        }
      ).then((value) {
        List<RecipePreview> recipes = [];
        for(dynamic entry in value.data) {
          recipes.add(
            RecipePreview(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              usernameCreator: entry["UsernameUtente"] as String
            )
          );
          emit(
            FeedRecipesLoaded(
              userRecipes: recipes,
              savedRecipes: state.savedRecipes
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadRecipesSavedByUserRequest(
    LoadRecipesSavedByUserRequest event,
    Emitter<FeedRecipesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/recipesSavedByUser",
        data: {
          "username": event.username
        }
      ).then((value) {
        List<RecipePreview> recipes = [];
        for(dynamic entry in value.data) {
          recipes.add(
            RecipePreview(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              usernameCreator: entry["UsernameUtente"] as String
            )
          );
          emit(
            FeedRecipesLoaded(
              userRecipes: state.userRecipes,
              savedRecipes: recipes
            )
          );
        }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
