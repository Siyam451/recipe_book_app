import 'package:flutter/material.dart';

class SavedToggle extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const SavedToggle({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          _toggleButton("Untried", 0),
          _toggleButton("Made it", 1),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, int index) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.orange
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color:
              isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}