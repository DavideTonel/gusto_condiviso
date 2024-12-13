class Ingredient {
  final String name;

  Ingredient({required this.name});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}

class IngredientCategory {
  final int id;
  final String name;

  IngredientCategory({required this.id, required this.name});
}

class IngredientInfo {
  final String name;
  final IngredientCategory category;

  IngredientInfo({required this.name, required this.category});
}
