import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:meta/meta.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeInitial()) {
    on<LoadRecipeRequest>(onLoadRecipeRequest);
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
        //dev.log(value.toString());
        final id = value.data["Codice"] as int;
        //dev.log("id: $id");
        final usernameUtente = value.data["UsernameUtente"] as String;
        //dev.log("usernameUtente: $usernameUtente");
        final recipeName = value.data["Nome"] as String;
        //dev.log("recipeName: $recipeName");
        final recipeDescription = value.data["DescrizioneRicetta"] as String;
        //dev.log("recipeDescription: $recipeDescription");

        String? revisitedRecipeId;
        try {
          revisitedRecipeId = (value.data["CodiceRicettaRivisitata"] as int).toString();
        } catch (e) {
          dev.log(e.toString());
        }

        //dev.log(value.data["Passaggi"].toString());

        List<RecipeStep> steps = [];

        for (var row in value.data["Passaggi"]) {
          //dev.log(row.toString());
          final stepDescription = row["DescrizionePassaggio"] as String;
          List<IngredientInStep> ingredientsInStep = [];
          List<Tool> toolsInStep = [];
          
          for (var i in row["Ingredienti"]) {
            //dev.log(i.toString());
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
            //dev.log(t.toString());
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
            )
          )
        );
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }
}
