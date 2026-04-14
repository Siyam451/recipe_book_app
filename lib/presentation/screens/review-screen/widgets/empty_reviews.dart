import 'package:flutter/material.dart';

class EmptyReviews extends StatelessWidget {
  const EmptyReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0D6),
              borderRadius: BorderRadius.circular(36),
            ),
            child: const Icon(
              Icons.rate_review_outlined,
              size: 36,
              color: Color(0xFFE8603C),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No reviews yet',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF444444)),
          ),
          const SizedBox(height: 6),
          const Text(
            'Be the first to share your thoughts!',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}