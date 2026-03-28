import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_strings.dart';
import '../../search-by-name/search_by_name_screen.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  String userName = "Guest";

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString("user_name");

    setState(() {
      userName = name ?? "Guest";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(AppStrings.profileImageUrl),
        ),

        const SizedBox(width: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),

            /// 🔥 DYNAMIC NAME
            Text(
              userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
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