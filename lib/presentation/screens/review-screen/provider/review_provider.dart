import 'package:flutter/material.dart';

import '../../../../data/models/review_model.dart';

class ReviewProvider extends ChangeNotifier {
  final List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  List<Review> getReviewsForRecipe(String recipeId) {
    return _reviews.where((r) => r.recipeId == recipeId).toList();
  }

  void addReview(Review review) {
    _reviews.insert(0, review);
    notifyListeners();
  }
}