import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Or continue with"),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(child: Icon(Icons.g_mobiledata)),
            SizedBox(width: 10),
            CircleAvatar(child: Icon(Icons.apple)),
            SizedBox(width: 10),
            CircleAvatar(child: Icon(Icons.facebook)),
          ],
        ),
      ],
    );
  }
}