import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          _buildItem(Icons.home, 0),

          _buildItem(Icons.receipt_long, 1),

          /// Center Floating Button
          GestureDetector(
            onTap: () => onItemTapped(2),
            child: Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          _buildItem(Icons.bookmark_border, 3),

          _buildItem(Icons.person_outline, 4),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Icon(
        icon,
        size: 26,
        color: isSelected ? Colors.orange : Colors.black54,
      ),
    );
  }
}