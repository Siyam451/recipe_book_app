import 'package:flutter/material.dart';
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Welcome Back 👩‍🍳",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          "Let’s cook something delicious today!",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}