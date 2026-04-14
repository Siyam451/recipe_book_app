import 'package:flutter/material.dart';
import '../../../../domain/entities/recipes.dart';
import '../../details/details_screen.dart';
import '../../review-screen/review_screen.dart';
import '../../review-screen/widgets/add_review_dialog.dart';

class RecipeCard extends StatelessWidget {
  final String id;
  final String image;
  final String rating;
  final String title;
  final String author;
  final bool isSaved;
  final Function(String) onToggle;

  const RecipeCard({
    super.key,
    required this.id,
    required this.image,
    required this.rating,
    required this.title,
    required this.author,
    required this.isSaved,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // ✅ ensures full area clickable
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailsScreen(
              recipe: Recipe(
                id: int.parse(id),
                title: title,
                image: image,
                rating: double.parse(rating),
                author: author, // ✅ use real author
              ),
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔥 IMAGE + OVERLAYS
          Stack(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// ⭐ RATING (opens dialog only)
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AddReviewDialog(
                        recipeId: id,
                        recipeImage: image,
                        recipeTitle: title,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onToggle(id),
                  child: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// 📝 TITLE
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 4),


          Text(
            "By: $author",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}