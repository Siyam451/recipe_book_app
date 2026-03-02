import '../../domain/entities/recipes.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required super.id,
    required super.title,
    required super.image,
    required super.author,
    required super.rating,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      author: json['author'] ?? "Unknown",
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "image": image,
      "author": author,
      "rating": rating,
    };
  }
}