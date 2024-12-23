/*
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/ingredient/ingredient.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:gusto_condiviso/model/recipe/tool/tool.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as dev;

part 'recipe_step_update_event.dart';
part 'recipe_step_update_state.dart';

class RecipeStepUpdateBloc extends Bloc<RecipeStepUpdateEvent, RecipeStepUpdateState> {
  RecipeStepUpdateBloc() : super(const RecipeStepUpdateInitial()) {
    on<LoadRecipeStep>(onLoadRecipeStep);

    on<LoadAvailableIngredientsRequest>(onLoadAvailableIngredientsRequest);

    on<LoadAvailableToolsRequest>(onLoadAvailableToolsRequest);

    on<SetDescriptionInCurrentStepEvent>((event, emit) {
      emit(
        RecipeStepUpdateInProgress(
          currentIngredientSelected: state.currentIngredientSelected,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentStepDescription: event.description,
          currentStepNumber: state.currentStepNumber
        )
      );
    });

    on<SetCurrentIngredientSelectedEvent>((event, emit) {
      emit(
        RecipeStepUpdateInProgress(
          currentStepDescription: state.currentStepDescription,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentIngredientSelected: event.ingredient,
          currentStepNumber: state.currentStepNumber
        )
      );
    });

    on<SetCurrentToolSelectedEvent>((event, emit) {
      emit(
        RecipeStepUpdateInProgress(
          currentStepDescription: state.currentStepDescription,
          currentIngredientSelected: state.currentIngredientSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentToolSelected: event.tool,
          currentStepNumber: state.currentStepNumber
        )
      );
    });

    on<SaveIngredientInCurrentStepEvent>((event, emit) {
      final newCurrentIngredients = [
        ...state.currentIngredients,
        IngredientInStep(
          ingredient: state.currentIngredientSelected!,
          amount: event.amount
        )
      ];

      emit(
        RecipeStepUpdateInProgress(
          currentStepDescription: state.currentStepDescription,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          currentIngredients: newCurrentIngredients,
          currentTools: state.currentTools,
          currentIngredientSelected: null,
          currentStepNumber: state.currentStepNumber
        )
      );
    });

    on<SaveToolInCurrentStepEvent>((event, emit) {
      final newCurrentTools = [
        ...state.currentTools,
        state.currentToolSelected!
      ];

      emit(
        RecipeStepUpdateInProgress(
          currentStepDescription: state.currentStepDescription,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          currentIngredients: state.currentIngredients,
          currentTools: newCurrentTools,
          currentIngredientSelected: null,
          currentStepNumber: state.currentStepNumber
        )
      );
    });

    on<UpdateRecipeStepEvent>(onUpdateRecipeStepEvent);

    on<ClearRecipeStep>((event, emit) {
      emit(
        const RecipeStepUpdateInitial()
      );
    });
  }

  FutureOr<void> onLoadRecipeStep(
    LoadRecipeStep event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/recipeStep",
        data: {
          "recipeId": event.recipeId,
          "stepNumber": event.stepNumber
        }
      ).then((value) {
        List<IngredientInStep> ingredientsInStep = [];
        List<Tool> toolsInStep = [];

        for (var i in value.data["Ingredienti"]) {
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

        for (var t in value.data["Utensili"]) {
          if (t["NomeUtensile"] != null) {
            final toolName = t["NomeUtensile"] as String;
            toolsInStep.add(
              Tool(
                name: toolName
              )
            );
          }
        }

        emit(
          RecipeStepUpdateInProgress(
            currentStepNumber: value.data["NumeroPassaggio"],
            currentStepDescription: value.data["DescrizionePassaggio"],
            currentIngredientSelected: null,
            currentToolSelected: null,
            availableIngredients: state.availableIngredients,
            availableTools: state.availableTools,
            currentIngredients: ingredientsInStep,
            currentTools: toolsInStep,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onUpdateRecipeStepEvent(
    UpdateRecipeStepEvent event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var step = RecipeStep(
        description: state.currentStepDescription,
        ingredients: state.currentIngredients,
        tools: state.currentTools
      );
      var stepJson = jsonEncode(step.toJson());

      var client = DioClient();
      await client.dio.post(
        "api/updateRecipeStep",
        data: {
          "recipeId": event.recipeId,
          "stepNumber": event.stepNumber,
          "step": stepJson
        }
      ).then((value) {

      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadAvailableIngredientsRequest(
    LoadAvailableIngredientsRequest event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/ingredients"
      ).then((value) {
        List<Ingredient> ingredients = [];
        for(dynamic entry in value.data) {
          ingredients.add(
            Ingredient(
              name: entry["Nome"] as String
            )
          );
        }
        emit(
          RecipeStepUpdateInProgress(
            currentStepNumber: state.currentStepNumber,
            currentStepDescription: state.currentStepDescription,
            currentIngredientSelected: state.currentIngredientSelected,
            currentToolSelected: state.currentToolSelected,
            availableIngredients: ingredients,
            availableTools: state.availableTools,
            currentIngredients: state.currentIngredients,
            currentTools: state.currentTools,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadAvailableToolsRequest(
    LoadAvailableToolsRequest event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/tools"
      ).then((value) {
        List<Tool> tools = [];
        for(dynamic entry in value.data) {
          tools.add(
            Tool(
              name: entry["Nome"] as String
            )
          );
        }
        emit(
          RecipeStepUpdateInProgress(
            currentStepNumber: state.currentStepNumber,
            currentStepDescription: state.currentStepDescription,
            currentIngredientSelected: state.currentIngredientSelected,
            currentToolSelected: state.currentToolSelected,
            availableIngredients: state.availableIngredients,
            availableTools: tools,
            currentIngredients: state.currentIngredients,
            currentTools: state.currentTools,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
*/

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/ingredient/ingredient.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';
import 'package:gusto_condiviso/model/recipe/tool/tool.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as dev;

part 'recipe_step_update_event.dart';
part 'recipe_step_update_state.dart';

class RecipeStepUpdateBloc extends Bloc<RecipeStepUpdateEvent, RecipeStepUpdateState> {
  RecipeStepUpdateBloc() : super(const RecipeStepUpdateInitial()) {
    on<LoadRecipeStep>(onLoadRecipeStep);

    on<LoadAvailableIngredientsRequest>(onLoadAvailableIngredientsRequest);

    on<LoadAvailableToolsRequest>(onLoadAvailableToolsRequest);

    on<SetDescriptionInCurrentStepEvent>((event, emit) {
      emit(
        RecipeStepUpdateInProgress(
          currentIngredientSelected: state.currentIngredientSelected,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentStepDescription: event.description,
          currentStepNumber: state.currentStepNumber
        )
      );
    });

    on<SetCurrentIngredientSelectedEvent>((event, emit) {
      emit(
        RecipeStepUpdateInProgress(
          currentStepDescription: state.currentStepDescription,
          currentToolSelected: state.currentToolSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentIngredientSelected: event.ingredient,
          currentStepNumber: state.currentStepNumber
        )
      );
    });

    on<SetCurrentToolSelectedEvent>((event, emit) {
      emit(
        RecipeStepUpdateInProgress(
          currentStepDescription: state.currentStepDescription,
          currentIngredientSelected: state.currentIngredientSelected,
          availableIngredients: state.availableIngredients,
          availableTools: state.availableTools,
          currentIngredients: state.currentIngredients,
          currentTools: state.currentTools,
          currentToolSelected: event.tool,
          currentStepNumber: state.currentStepNumber
        )
      );
    });

    on<SaveToolInCurrentStepEvent>(onSaveToolInCurrentStep);

    on<RemoveToolFromCurrentStepEvent>(onRemoveToolFromCurrentStepEvent);

    on<SaveIngredientInCurrentStepEvent>(onSaveIngredientInCurrentStepEvent);

    on<RemoveIngredientInCurrentStepEvent>(onRemoveIngredientInCurrentStepEvent);

    on<UpdateDescriptionCurrentStepEvent>(onUpdateDescriptionCurrentStepEvent);

    on<ClearRecipeStep>((event, emit) {
      emit(
        const RecipeStepUpdateInitial()
      );
    });
  }

  FutureOr<void> onLoadRecipeStep(
    LoadRecipeStep event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/recipeStep",
        data: {
          "recipeId": event.recipeId,
          "stepNumber": event.stepNumber
        }
      ).then((value) {
        List<IngredientInStep> ingredientsInStep = [];
        List<Tool> toolsInStep = [];

        for (var i in value.data["Ingredienti"]) {
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

        for (var t in value.data["Utensili"]) {
          if (t["NomeUtensile"] != null) {
            final toolName = t["NomeUtensile"] as String;
            toolsInStep.add(
              Tool(
                name: toolName
              )
            );
          }
        }

        emit(
          RecipeStepUpdateInProgress(
            currentStepNumber: value.data["NumeroPassaggio"],
            currentStepDescription: value.data["DescrizionePassaggio"],
            currentIngredientSelected: null,
            currentToolSelected: null,
            availableIngredients: state.availableIngredients,
            availableTools: state.availableTools,
            currentIngredients: ingredientsInStep,
            currentTools: toolsInStep,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadAvailableIngredientsRequest(
    LoadAvailableIngredientsRequest event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/ingredients"
      ).then((value) {
        List<Ingredient> ingredients = [];
        for(dynamic entry in value.data) {
          ingredients.add(
            Ingredient(
              name: entry["Nome"] as String
            )
          );
        }
        emit(
          RecipeStepUpdateInProgress(
            currentStepNumber: state.currentStepNumber,
            currentStepDescription: state.currentStepDescription,
            currentIngredientSelected: state.currentIngredientSelected,
            currentToolSelected: state.currentToolSelected,
            availableIngredients: ingredients,
            availableTools: state.availableTools,
            currentIngredients: state.currentIngredients,
            currentTools: state.currentTools,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadAvailableToolsRequest(
    LoadAvailableToolsRequest event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/tools"
      ).then((value) {
        List<Tool> tools = [];
        for(dynamic entry in value.data) {
          tools.add(
            Tool(
              name: entry["Nome"] as String
            )
          );
        }
        emit(
          RecipeStepUpdateInProgress(
            currentStepNumber: state.currentStepNumber,
            currentStepDescription: state.currentStepDescription,
            currentIngredientSelected: state.currentIngredientSelected,
            currentToolSelected: state.currentToolSelected,
            availableIngredients: state.availableIngredients,
            availableTools: tools,
            currentIngredients: state.currentIngredients,
            currentTools: state.currentTools,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveToolInCurrentStep(
    SaveToolInCurrentStepEvent event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveToolInCurrentStep",
        data: {
          "toolName": event.toolName,
          "stepNumber": event.stepNumber,
          "recipeId": event.recipeId
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipeStep",
          data: {
            "recipeId": event.recipeId,
            "stepNumber": event.stepNumber
          }
        ).then((value) {
          List<IngredientInStep> ingredientsInStep = [];
          List<Tool> toolsInStep = [];

          for (var i in value.data["Ingredienti"]) {
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

          for (var t in value.data["Utensili"]) {
            if (t["NomeUtensile"] != null) {
              final toolName = t["NomeUtensile"] as String;
              toolsInStep.add(
                Tool(
                  name: toolName
                )
              );
            }
          }

          emit(
            RecipeStepUpdateInProgress(
              currentStepNumber: state.currentStepNumber,
              currentStepDescription: state.currentStepDescription,
              currentIngredientSelected: null,
              currentToolSelected: null,
              availableIngredients: state.availableIngredients,
              availableTools: state.availableTools,
              currentIngredients: ingredientsInStep,
              currentTools: toolsInStep,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onRemoveToolFromCurrentStepEvent(
    RemoveToolFromCurrentStepEvent event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/removeToolInCurrentStep",
        data: {
          "toolName": event.toolName,
          "stepNumber": event.stepNumber,
          "recipeId": event.recipeId
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipeStep",
          data: {
            "recipeId": event.recipeId,
            "stepNumber": event.stepNumber
          }
        ).then((value) {
          List<IngredientInStep> ingredientsInStep = [];
          List<Tool> toolsInStep = [];

          for (var i in value.data["Ingredienti"]) {
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

          for (var t in value.data["Utensili"]) {
            if (t["NomeUtensile"] != null) {
              final toolName = t["NomeUtensile"] as String;
              toolsInStep.add(
                Tool(
                  name: toolName
                )
              );
            }
          }

          emit(
            RecipeStepUpdateInProgress(
              currentStepNumber: state.currentStepNumber,
              currentStepDescription: state.currentStepDescription,
              currentIngredientSelected: null,
              currentToolSelected: null,
              availableIngredients: state.availableIngredients,
              availableTools: state.availableTools,
              currentIngredients: ingredientsInStep,
              currentTools: toolsInStep,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveIngredientInCurrentStepEvent(
    SaveIngredientInCurrentStepEvent event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveIngredientInCurrentStep",
        data: {
          "ingredientName": event.ingredientName,
          "amount": event.amount,
          "stepNumber": event.stepNumber,
          "recipeId": event.recipeId
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipeStep",
          data: {
            "recipeId": event.recipeId,
            "stepNumber": event.stepNumber
          }
        ).then((value) {
          List<IngredientInStep> ingredientsInStep = [];
          List<Tool> toolsInStep = [];

          for (var i in value.data["Ingredienti"]) {
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

          for (var t in value.data["Utensili"]) {
            if (t["NomeUtensile"] != null) {
              final toolName = t["NomeUtensile"] as String;
              toolsInStep.add(
                Tool(
                  name: toolName
                )
              );
            }
          }

          emit(
            RecipeStepUpdateInProgress(
              currentStepNumber: state.currentStepNumber,
              currentStepDescription: state.currentStepDescription,
              currentIngredientSelected: null,
              currentToolSelected: null,
              availableIngredients: state.availableIngredients,
              availableTools: state.availableTools,
              currentIngredients: ingredientsInStep,
              currentTools: toolsInStep,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onRemoveIngredientInCurrentStepEvent(
    RemoveIngredientInCurrentStepEvent event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/removeIngredientInCurrentStep",
        data: {
          "ingredientName": event.ingredientName,
          "stepNumber": event.stepNumber,
          "recipeId": event.recipeId
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipeStep",
          data: {
            "recipeId": event.recipeId,
            "stepNumber": event.stepNumber
          }
        ).then((value) {
          List<IngredientInStep> ingredientsInStep = [];
          List<Tool> toolsInStep = [];

          for (var i in value.data["Ingredienti"]) {
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

          for (var t in value.data["Utensili"]) {
            if (t["NomeUtensile"] != null) {
              final toolName = t["NomeUtensile"] as String;
              toolsInStep.add(
                Tool(
                  name: toolName
                )
              );
            }
          }

          emit(
            RecipeStepUpdateInProgress(
              currentStepNumber: state.currentStepNumber,
              currentStepDescription: state.currentStepDescription,
              currentIngredientSelected: null,
              currentToolSelected: null,
              availableIngredients: state.availableIngredients,
              availableTools: state.availableTools,
              currentIngredients: ingredientsInStep,
              currentTools: toolsInStep,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onUpdateDescriptionCurrentStepEvent(
    UpdateDescriptionCurrentStepEvent event,
    Emitter<RecipeStepUpdateState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/updateStepDescription",
        data: {
          "stepDescription": event.description,
          "stepNumber": event.stepNumber,
          "recipeId": event.recipeId
        }
      ).then((value) async {
        await client.dio.post(
          "api/recipeStep",
          data: {
            "recipeId": event.recipeId,
            "stepNumber": event.stepNumber
          }
        ).then((value) {
          List<IngredientInStep> ingredientsInStep = [];
          List<Tool> toolsInStep = [];

          for (var i in value.data["Ingredienti"]) {
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

          for (var t in value.data["Utensili"]) {
            if (t["NomeUtensile"] != null) {
              final toolName = t["NomeUtensile"] as String;
              toolsInStep.add(
                Tool(
                  name: toolName
                )
              );
            }
          }

          emit(
            RecipeStepUpdateInProgress(
              currentStepNumber: state.currentStepNumber,
              currentStepDescription: value.data["DescrizionePassaggio"],
              currentIngredientSelected: null,
              currentToolSelected: null,
              availableIngredients: state.availableIngredients,
              availableTools: state.availableTools,
              currentIngredients: ingredientsInStep,
              currentTools: toolsInStep,
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
