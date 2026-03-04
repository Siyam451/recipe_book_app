class SearchRecipeModel {
  final List<SearchRecipe> results;
  final int offset;
  final int number;
  final int totalResults;

  SearchRecipeModel({
    required this.results,
    required this.offset,
    required this.number,
    required this.totalResults,
  });

  factory SearchRecipeModel.fromJson(Map<String, dynamic> json) {
    return SearchRecipeModel(
      results: (json['results'] as List)
          .map((e) => SearchRecipe.fromJson(e))
          .toList(),
      offset: json['offset'],
      number: json['number'],
      totalResults: json['totalResults'],
    );
  }
}

class SearchRecipe {
  final int id;
  final String title;
  final String image;

  SearchRecipe({
    required this.id,
    required this.title,
    required this.image,
  });

  factory SearchRecipe.fromJson(Map<String, dynamic> json) {
    return SearchRecipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}