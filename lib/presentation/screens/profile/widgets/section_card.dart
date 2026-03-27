import 'package:flutter/material.dart';
import '../models/profile_item_model.dart';
import 'profile_tile.dart';

class SectionCard extends StatelessWidget {
  final List<ProfileItem> items;

  const SectionCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: BorderRadius.circular(20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ProfileTile(item: items[index]);
        },
      ),
    );
  }
}