import 'package:gusto_condiviso/model/recipe/ingredient/ingredient.dart';
import 'package:gusto_condiviso/model/recipe/tool/tool.dart';

class Recipe {
  final int id;
  final String usernameCreator;
  final String name;
  final String description;
  final double rating;
  final int numOfReviews;
  final String personPerDose;
  final String pubDate;
  final List<RecipeStep> steps;
  final String? revisitedRecipeId;

  Recipe(
    {
      required this.id,
      required this.usernameCreator,
      required this.name,
      required this.description,
      required this.rating,
      required this.numOfReviews,
      required this.personPerDose,
      required this.pubDate,
      required this.steps,
      required this.revisitedRecipeId
    }
  );
}

class RecipePreview {
  final int id;
  final String name;
  final String usernameCreator;
  final String? saveDate;

  RecipePreview(
    {
      required this.id,
      required this.name,
      required this.usernameCreator,
      this.saveDate
    }
  );
}

class RecipeCategory {
  final int id;
  final String name;

  RecipeCategory({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }  
}

class RecipeStep {
  final String description;
  final List<IngredientInStep> ingredients;
  final List<Tool> tools;

  RecipeStep({required this.description, required this.ingredients, required this.tools});

  Map<String, dynamic> toJson() {
    return {
      "ingredients": ingredients.map((i) => i.toJson()).toList(),
      "tools": tools.map((t) => t.toJson()).toList(),
      "description": description,
    };
  }
}

class IngredientInStep {
  final String amount;
  final Ingredient ingredient;


  IngredientInStep({required this.amount, required this.ingredient});

  Map<String, dynamic> toJson() {
    return {
      "ingredient": ingredient.toJson(),
      "amount": amount,
    };
  }
}
