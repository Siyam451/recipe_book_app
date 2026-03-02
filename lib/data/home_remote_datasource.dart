import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/recipe_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<RecipeModel>> getPopularRecipes();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl(this.client);

  @override
  Future<List<RecipeModel>> getPopularRecipes() async {
    final response = await client.get(
      Uri.parse("https://yourapi.com/popular"),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load recipes");
    }
  }
}