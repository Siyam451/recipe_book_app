import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8E7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              const Text(
                "Discover",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const Text(
                "Delicious Recipes 🍳",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Find, cook and save your favorite recipes easily",
                style: TextStyle(color: Colors.grey),
              ),

              const Spacer(),

              Center(
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3075/3075977.png",
                  height: 220,
                ),
              ),

              const Spacer(),

              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text("Start"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}