class Recipe {
  final int id;
  final String usernameCreator;
  final String name;
  final String description;
  final List<RecipeStep> steps;

  Recipe({required this.id, required this.usernameCreator, required this.name, required this.description, required this.steps});
}

class RecipePreview {
  final int id;
  final String name;
  final String usernameCreator;

  RecipePreview({required this.id, required this.name, required this.usernameCreator});
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

class Ingredient {
  final String name;

  Ingredient({required this.name});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}

class Tool {
  final String name;

  Tool({required this.name});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}