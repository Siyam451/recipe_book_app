import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../common/screens/main_navigation_screen.dart';
import 'auth_field.dart';
import 'login_button.dart';
import 'social_login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool rememberMe = false;
  bool isLoading = false;

  void onLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        );

      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Login failed")),
        );
      }

      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// COMBINED FIELDS
            AuthFields(
              emailController: emailController,
              passwordController: passwordController,
              obscurePassword: obscurePassword,
              rememberMe: rememberMe,
              onTogglePassword: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              onRememberChanged: (val) {
                setState(() {
                  rememberMe = val;
                });
              },
            ),

            const SizedBox(height: 20),

            /// BUTTON
            LoginButton(
              isLoading: isLoading,
              onPressed: onLogin,
            ),

            const SizedBox(height: 20),

            /// SOCIAL
            const SocialLogin(),
          ],
        ),
      ),
    );
  }
}