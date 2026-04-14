class Review {
  final String recipeId;
  final String name;
  final String comment;
  final double rating;
  final String time;

  Review({
    required this.name,
    required this.comment,
    required this.rating,
    required this.time,
    required this.recipeId,
  });
}