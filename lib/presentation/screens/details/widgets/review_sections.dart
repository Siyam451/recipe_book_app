import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../review-screen/provider/review_provider.dart';
import '../../review-screen/review_screen.dart';
import '../../review-screen/widgets/add_review_dialog.dart';
import '../../review-screen/widgets/review_card.dart';
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({
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
    final theme = Theme.of(context);
    final reviews =
    context.watch<ReviewProvider>().getReviewsForRecipe(recipeId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                if (reviews.isNotEmpty)
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewScreen(
                          recipeId: recipeId,
                          recipeImage: recipeImage,
                          recipeTitle: recipeTitle,
                        ),
                      ),
                    ),
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        color: Color(0xFFE8603C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AddReviewDialog(
                      recipeId: recipeId,
                      recipeImage: recipeImage,
                      recipeTitle: recipeTitle,
                    ),
                  ),
                  child: const Icon(Icons.add, color: Colors.orange),
                )
              ],
            )
          ],
        ),

        const SizedBox(height: 10),

        /// Empty state
        if (reviews.isEmpty)
          const Text("No reviews yet"),

        /// Show 2 reviews
        if (reviews.isNotEmpty)
          ...reviews.take(2).map((r) => ReviewCard(review: r)),
      ],
    );
  }
}