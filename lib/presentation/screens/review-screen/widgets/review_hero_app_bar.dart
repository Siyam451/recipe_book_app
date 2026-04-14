import 'package:flutter/material.dart';

class ReviewHeroAppBar extends StatelessWidget {
  const ReviewHeroAppBar({
    super.key,
    required this.recipeImage,
    required this.recipeTitle,
    required this.reviews,
  });

  final String recipeImage;
  final String recipeTitle;
  final List reviews;

  double _averageRating() {
    if (reviews.isEmpty) return 0;
    return reviews.map((r) => r.rating).reduce((a, b) => a + b) /
        reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.black45,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(recipeImage, fit: BoxFit.cover),

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC000000)],
                  stops: [0.5, 1.0],
                ),
              ),
            ),

            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipeTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFC107), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        reviews.isEmpty
                            ? 'No reviews yet'
                            : '${_averageRating().toStringAsFixed(1)}  ·  '
                            '${reviews.length} review${reviews.length == 1 ? '' : 's'}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}