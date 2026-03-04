class RecipeDetailsModel {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;
  final double healthScore;
  final int aggregateLikes;
  final String summary;
  final List<Ingredient> ingredients;

  RecipeDetailsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.healthScore,
    required this.aggregateLikes,
    required this.summary,
    required this.ingredients,
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      readyInMinutes: json["readyInMinutes"],
      servings: json["servings"],
      healthScore: json["healthScore"].toDouble(),
      aggregateLikes: json["aggregateLikes"],
      summary: json["summary"] ?? "",
      ingredients: (json["extendedIngredients"] as List)
          .map((e) => Ingredient.fromJson(e))
          .toList(),
    );
  }
}

class Ingredient {
  final String name;
  final double amount;
  final String unit;
  final String image;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json["name"],
      amount: json["amount"].toDouble(),
      unit: json["unit"],
      image: json["image"],
    );
  }
}