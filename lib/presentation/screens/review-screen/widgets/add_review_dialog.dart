import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/review_model.dart';
import '../provider/review_provider.dart';

class AddReviewDialog extends StatefulWidget {
  final String recipeId;
  final String recipeImage;
  final String recipeTitle;

  const AddReviewDialog({
    super.key,
    required this.recipeId,
    required this.recipeImage,
    required this.recipeTitle,
  });

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double rating = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F5F0),
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24)),
                child: Stack(
                  children: [
                    Image.network(
                      widget.recipeImage,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    /// Gradient overlay
                    Container(
                      height: 180,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0xCC000000),
                          ],
                          stops: [0.4, 1.0],
                        ),
                      ),
                    ),
                    /// Title on image
                    Positioned(
                      bottom: 14,
                      left: 16,
                      right: 16,
                      child: Text(
                        widget.recipeTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    /// Close button
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(Icons.close,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Rating',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF888888),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
          

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final filled = index < rating;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => rating = index + 1.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            child: Icon(
                              filled
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              size: 38,
                              color: filled
                                  ? const Color(0xFFFFC107)
                                  : Colors.grey.shade300,
                            ),
                          ),
                        );
                      }),
                    ),
          
                    if (rating > 0) ...[
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          _ratingLabel(rating),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFE8603C),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
          
                    const SizedBox(height: 18),
          

                    const Text(
                      'Your Review',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF888888),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFE0DDD8), width: 1),
                      ),
                      child: TextField(
                        controller: _controller,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText:
                          'What did you think of this recipe?',
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 14),
                          contentPadding: EdgeInsets.all(14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
          
                    const SizedBox(height: 20),
          

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: rating == 0
                            ? null
                            : () {
                          final review = Review(
                            recipeId: widget.recipeId,
                            name: 'You',
                            comment: _controller.text.trim(),
                            rating: rating,
                            time: 'Just now',
                          );
                          Provider.of<ReviewProvider>(context,
                              listen: false)
                              .addReview(review);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE8603C),
                          disabledBackgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Submit Review',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
///rating system
  String _ratingLabel(double r) {
    switch (r.toInt()) {
      case 1: return 'Poor';
      case 2: return 'Fair';
      case 3: return 'Good';
      case 4: return 'Very Good';
      case 5: return 'Excellent!';
      default: return '';
    }
  }
}