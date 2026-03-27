import 'package:flutter/material.dart';
import '../models/profile_item_model.dart';

class ProfileTile extends StatelessWidget {
  final ProfileItem item;

  const ProfileTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(item.icon),
      ),
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}