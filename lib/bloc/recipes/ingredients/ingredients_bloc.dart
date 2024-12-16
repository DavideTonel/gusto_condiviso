import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/ingredient/ingredient.dart';
import 'package:meta/meta.dart';

part 'ingredients_event.dart';
part 'ingredients_state.dart';

class IngredientsBloc extends Bloc<IngredientsEvent, IngredientsState> {
  IngredientsBloc() : super(const IngredientsInitial()) {
    on<LoadIngredientCategories>(onLoadIngredientCategories);

    on<LoadIngredients>(onLoadIngredients);

    on<SaveIngredientCategory>(onSaveIngredientCategory);

    on<SaveIngredient>(onSaveIngredient);

    on<DeleteIngredientCategory>(onDeleteIngredientCategory);

    on<DeleteIngredient>(onDeleteIngredient);
  }

  FutureOr<void> onLoadIngredientCategories(
    LoadIngredientCategories event,
    Emitter<IngredientsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/ingredientCategories"
      ).then((value) {
        List<IngredientCategory> categories = [];
        for (dynamic entry in value.data) {
          categories.add(
            IngredientCategory(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String
            )
          );
        }

        emit(
          IngredientsLoaded(
            availableCategories: categories,
            availableIngredients: state.availableIngredients,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadIngredients(
    LoadIngredients event,
    Emitter<IngredientsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/ingredients"
      ).then((value) {
        List<IngredientInfo> ingredients = [];
        for(dynamic entry in value.data) {
          ingredients.add(
            IngredientInfo(
              name: entry["Nome"] as String,
              category: IngredientCategory(
                id: entry["CodiceCategoria"] as int,
                name: entry["NomeCategoria"]
              )
            )
          );
        }
        emit(
          IngredientsLoaded(
            availableCategories: state.availableCategories,
            availableIngredients: ingredients,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
  // Aggiungere data di salvataggio della ricetta da parte dell'utente
  FutureOr<void> onSaveIngredientCategory(
    SaveIngredientCategory event,
    Emitter<IngredientsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveIngredientCategory",
        data: {
          "name": event.name
        }
      ).then((value) async {
        await client.dio.post(
          "api/ingredientCategories"
        ).then((value) {
          List<IngredientCategory> categories = [];
          for (dynamic entry in value.data) {
            categories.add(
              IngredientCategory(
                id: entry["Codice"] as int,
                name: entry["Nome"] as String
              )
            );
          }

          emit(
            IngredientsLoaded(
              availableCategories: categories,
              availableIngredients: state.availableIngredients,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveIngredient(
    SaveIngredient event,
    Emitter<IngredientsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveIngredient",
        data: {
          "name": event.name,
          "categoryId": event.categoryId
        }
      ).then((value) async {
        await client.dio.post(
          "api/ingredients"
        ).then((value) {
          List<IngredientInfo> ingredients = [];
          for (dynamic entry in value.data) {
            ingredients.add(
              IngredientInfo(
                name: entry["Nome"] as String,
                category: IngredientCategory(
                  id: entry["CodiceCategoria"] as int,
                  name: entry["NomeCategoria"] as String
                )
              )
            );
          }

          emit(
            IngredientsLoaded(
              availableCategories: state.availableCategories,
              availableIngredients: ingredients,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onDeleteIngredientCategory(
    DeleteIngredientCategory event,
    Emitter<IngredientsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/deleteIngredientCategory",
        data: {
          "id": event.id
        }
      ).then((value) async {
        await client.dio.post(
          "api/ingredientCategories"
        ).then((value) {
          List<IngredientCategory> categories = [];
          for (dynamic entry in value.data) {
            categories.add(
              IngredientCategory(
                id: entry["Codice"] as int,
                name: entry["Nome"] as String
              )
            );
          }

          emit(
            IngredientsLoaded(
              availableCategories: categories,
              availableIngredients: state.availableIngredients,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onDeleteIngredient(
    DeleteIngredient event,
    Emitter<IngredientsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/deleteIngredient",
        data: {
          "name": event.name
        }
      ).then((value) async {
        await client.dio.post(
          "api/ingredients"
        ).then((value) {
          List<IngredientInfo> ingredients = [];
          for (dynamic entry in value.data) {
            ingredients.add(
              IngredientInfo(
                name: entry["Nome"] as String,
                category: IngredientCategory(
                  id: entry["CodiceCategoria"] as int,
                  name: entry["NomeCategoria"] as String
                )
              )
            );
          }

          emit(
            IngredientsLoaded(
              availableCategories: state.availableCategories,
              availableIngredients: ingredients,
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
