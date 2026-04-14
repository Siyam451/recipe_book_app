import 'package:flutter/material.dart';
import 'package:recipebookapp/presentation/screens/auth-screens/login/widgets/login_form.dart';
import '../register/register_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8E7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              /// HEADER
              const Text(
                "Welcome Back 👩‍🍳",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Let’s cook something delicious today!",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              /// FORM
              const LoginForm(),

              const SizedBox(height: 30),

              /// REGISTER
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    "New here? Create an account",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}