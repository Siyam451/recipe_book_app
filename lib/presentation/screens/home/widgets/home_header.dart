import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_strings.dart';
import '../../auth-screens/onboarding/onboarding_screen.dart';
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

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    final prefs = await SharedPreferences.getInstance();


    await prefs.remove("access-token");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => OnboardingScreen()),
          (route) => false,
    );
  }

  Future<void> loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    setState(() {
      userName = user?.displayName ?? "Guest";
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

        Row(
          children: [
            const Icon(Icons.notifications_active),

            const SizedBox(width: 8),

            IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: logout,
            ),
          ],
        )
      ],
    );
  }
}