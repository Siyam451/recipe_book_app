import '../../domain/entities/recipes.dart';

class RecipeModel {
  final int id;
  final String title;
  final String image;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Recipe toEntity() {
    return Recipe(
      id: id,
      title: title,
      image: image,
      author: "Unknown",   // default value
      rating: 0.0,         // default value
    );
  }
}