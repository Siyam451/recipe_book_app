import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/screens/review-screen/provider/review_provider.dart';
import 'package:recipebookapp/presentation/screens/review-screen/widgets/add_review_dialog.dart';
import 'package:recipebookapp/presentation/screens/review-screen/widgets/empty_reviews.dart';
import 'package:recipebookapp/presentation/screens/review-screen/widgets/review_card.dart';
import 'package:recipebookapp/presentation/screens/review-screen/widgets/review_hero_app_bar.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    super.key,
    required this.recipeId,
    required this.recipeImage,
    required this.recipeTitle,
  });

  final String recipeId;
  final String recipeImage;
  final String recipeTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F0),
      body: Consumer<ReviewProvider>(
        builder: (context, reviewProvider, child) {
          final reviews = reviewProvider.getReviewsForRecipe(recipeId);

          return CustomScrollView(
            slivers: [
              ReviewHeroAppBar(
                recipeImage: recipeImage,
                recipeTitle: recipeTitle,
                reviews: reviews,
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),

              reviews.isEmpty
                  ? const SliverFillRemaining(child: EmptyReviews())
                  : SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                        ReviewCard(review: reviews[index]),
                    childCount: reviews.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AddReviewDialog(
            recipeId: recipeId,
            recipeImage: recipeImage,
            recipeTitle: recipeTitle,
          ),
        ),
        backgroundColor: const Color(0xFFE8603C),
        icon: const Icon(Icons.edit_rounded, color: Colors.white),
        label: const Text(
          'Write a Review',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}