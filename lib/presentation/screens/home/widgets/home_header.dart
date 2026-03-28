import 'package:flutter/material.dart';

import '../../../../core/app_strings.dart';
import '../../search-by-name/search_by_name_screen.dart';
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(AppStrings.profileImageUrl),
        ),
        const SizedBox(width: 10),

        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back!", style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 4),
            Text("Shahrina sultana Liza",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),

        const Spacer(),

        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchByNameScreen()),
            );
          },
        ),

        const Icon(Icons.notifications_active),
      ],
    );
  }
}