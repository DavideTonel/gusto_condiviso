import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'feed_recipes_event.dart';
part 'feed_recipes_state.dart';

class FeedRecipesBloc extends Bloc<FeedRecipesEvent, FeedRecipesState> {
  FeedRecipesBloc() : super(const FeedRecipesInitial()) {
    on<LoadRecipesMadeByUserRequest>(onLoadRecipesMadeByUserRequest);

    on<LoadRecipesSavedByUserRequest>(onLoadRecipesSavedByUserRequest);

    on<ToggleFavoriteRecipe>(onToggleFavoriteRecipe);
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
        }
        emit(
          FeedRecipesLoaded(
            userRecipes: recipes,
            savedRecipes: state.savedRecipes
          )
        );
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
        dev.log("Load saved recipes");
        List<RecipePreview> recipes = [];
        for(dynamic entry in value.data) {
          recipes.add(
            RecipePreview(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              usernameCreator: entry["UsernameUtente"] as String,
              saveDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataSalvataggio"] as String))
            )
          );
          
          dev.log("Saved recipes: ");
          dev.log(entry.toString());
          dev.log("end saved recipes");

        }
        emit(
          FeedRecipesLoaded(
            userRecipes: state.userRecipes,
            savedRecipes: recipes
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onToggleFavoriteRecipe(
    ToggleFavoriteRecipe event,
    Emitter<FeedRecipesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/toggleFavoriteRecipe",
        data: {
          "recipeId": event.recipeId,
          "username": event.username
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipesSavedByUser",
          data: {
            "username": event.username
          }
        ).then((value) {
          dev.log("Load saved recipes");
          List<RecipePreview> recipes = [];
          for(dynamic entry in value.data) {
            recipes.add(
              RecipePreview(
                id: entry["Codice"] as int,
                name: entry["Nome"] as String,
                usernameCreator: entry["UsernameUtente"] as String
              )
            );
          
            dev.log("Saved recipes: ");
            dev.log(entry.toString());
            dev.log("end saved recipes");
          }
          emit(
            FeedRecipesLoaded(
              userRecipes: state.userRecipes,
              savedRecipes: recipes
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
