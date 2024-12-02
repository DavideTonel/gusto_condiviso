import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:gusto_condiviso/pages/recipes/recipe_reviews_page.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeInitial()) {
    on<LoadRecipeRequest>(onLoadRecipeRequest);

    on<LoadRecipeReviewsRequest>(onLoadRecipeReviewsRequest);

    on<SetReviewScore>((event, emit) {
      emit(
        RecipeLoaded(
          recipe: state.recipe,
          reviews: state.reviews,
          currentReviewScore: event.score,
          currentReviewDescription: state.currentReviewDescription
        )
      );
    });

    on<SetReviewDescription>((event, emit) {
      emit(
        RecipeLoaded(
          recipe: state.recipe,
          reviews: state.reviews,
          currentReviewScore: state.currentReviewScore,
          currentReviewDescription: event.description
        )
      );
    });

    on<SaveReviewRequest>(onSaveReviewRequest);

    on<ClearReviewCreation>((event, emit) {
      emit(
        RecipeLoaded(
          recipe: state.recipe,
          reviews: state.reviews,
          currentReviewDescription: null,
          currentReviewScore: null
        )
      );
    });
  }

  FutureOr<void> onLoadRecipeRequest(
    LoadRecipeRequest event,
    Emitter<RecipeState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/recipe",
        data: {
          "recipeId": event.recipeId
        }
      ).then((value) {
        final id = value.data["Codice"] as int;
        final usernameUtente = value.data["UsernameUtente"] as String;
        final recipeName = value.data["Nome"] as String;
        final recipeDescription = value.data["DescrizioneRicetta"] as String;

        String? revisitedRecipeId;
        try {
          revisitedRecipeId = (value.data["CodiceRicettaRivisitata"] as int).toString();
        } catch (e) {
          dev.log("Recipe is not a revisitation");
        }

        List<RecipeStep> steps = [];

        for (var row in value.data["Passaggi"]) {
          final stepDescription = row["DescrizionePassaggio"] as String;
          List<IngredientInStep> ingredientsInStep = [];
          List<Tool> toolsInStep = [];
          
          for (var i in row["Ingredienti"]) {
            if (i["NomeIngrediente"] != null) {
              final ingredientName = i["NomeIngrediente"] as String;
              final amount = i["Quantità"] as String;

              ingredientsInStep.add(
                IngredientInStep(
                  ingredient: Ingredient(
                    name: ingredientName
                  ),
                  amount: amount
                )
              );
            }
          }

          for (var t in row["Utensili"]) {
            if (t["NomeUtensile"] != null) {
              final toolName = t["NomeUtensile"] as String;
              toolsInStep.add(
                Tool(
                  name: toolName
                )
              );
            }
          }

          steps.add(
            RecipeStep(
              description: stepDescription,
              ingredients: ingredientsInStep,
              tools: toolsInStep
            )
          );
        }

        emit(
          RecipeLoaded(
            recipe: Recipe(
              id: id,
              usernameCreator: usernameUtente,
              name: recipeName,
              description: recipeDescription,
              steps: steps,
              revisitedRecipeId: revisitedRecipeId
            ),
            reviews: state.reviews
          )
        );
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadRecipeReviewsRequest(
    LoadRecipeReviewsRequest event,
    Emitter<RecipeState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/recipeReviews",
        data: {
          "recipeId": event.recipeId
        }
      ).then((value) {
        List<RecipeReview> reviews = [];

        for (var row in value.data) {
          //dev.log(row.toString());
          final usernameCreator = row["UsernameUtente"] as String;
          final score = row["Punteggio"] as int;
          final date = DateFormat('dd/MM/yyyy').format(DateTime.parse(row["DataCreazione"] as String));

          String? description;
          try {
            description = row["Descrizione"] as String;        
          } catch (e) {
            dev.log("Review has no description");
          }

          reviews.add(
            RecipeReview(
              usernameCreator: usernameCreator,
              score: score,
              date: date,
              description: description,
            )
          );
        }

        emit(
          RecipeLoaded(
            recipe: state.recipe,
            reviews: reviews
          )
        );
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveReviewRequest(
    SaveReviewRequest event,
    Emitter<RecipeState> emit
  ) async {
    dev.log(state.currentReviewDescription ?? "niente");
    try {
      final client = DioClient();
      await client.dio.post(
        "api/saveRecipeReview",
        data: {
          "recipeId": state.recipe?.id,
          "usernameCreator": event.usernameReviewCreator,
          "score": state.currentReviewScore,
          "description": state.currentReviewDescription,
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipeReviews",
          data: {
            "receipeId": state.recipe?.id
          }
        ).then((value) {
          List<RecipeReview> reviews = [];

          for (var row in value.data) {
            //dev.log(row.toString());
            final usernameCreator = row["UsernameUtente"] as String;
            final score = row["Punteggio"] as int;
            final date = DateFormat('dd/MM/yyyy').format(DateTime.parse(row["DataCreazione"] as String));

            String? description;
            try {
              description = row["Descrizione"] as String;        
            } catch (e) {
              dev.log("Review has no description");
            }

            reviews.add(
              RecipeReview(
                usernameCreator: usernameCreator,
                score: score,
                date: date,
                description: description,
              )
            );
          }

          emit(
            RecipeLoaded(
              recipe: state.recipe,
              reviews: reviews
            )
          );
        });
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }
}
