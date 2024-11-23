enum RecipeSearchType {
  byId("Codice"),
  byName("Nome"),
  byCategories("Categorie"),
  byNameAndCategories("Nome e categorie"),
  byIngredients("Ingredienti"),
  byTools("Utensili"),
  byIngredientsAndTools("Ingredienti ed utensili");

  final String name;
  const RecipeSearchType(this.name);
}
