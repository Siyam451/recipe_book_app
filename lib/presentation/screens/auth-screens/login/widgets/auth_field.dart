import 'package:flutter/material.dart';

import '../../../../../core/utilites/input_decoration.dart';

class AuthFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool rememberMe;
  final VoidCallback onTogglePassword;
  final Function(bool) onRememberChanged;

  const AuthFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.rememberMe,
    required this.onTogglePassword,
    required this.onRememberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// EMAIL
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: inputDecoration("Email", Icons.email),
          validator: (value) {
            if (value == null || value.isEmpty) return "Email required";
            if (!value.contains("@")) return "Enter valid email";
            return null;
          },
        ),

        const SizedBox(height: 15),

        /// PASSWORD
        TextFormField(
          controller: passwordController,
          obscureText: obscurePassword,
          decoration: inputDecoration(
            "Password",
            Icons.lock,
            suffix: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: onTogglePassword,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return "Password required";
            if (value.length < 6) return "Minimum 6 characters";
            return null;
          },
        ),

        const SizedBox(height: 10),

        /// REMEMBER + FORGOT
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (val) => onRememberChanged(val!),
            ),
            const Text("Remember me"),
            const Spacer(),
            TextButton(
              onPressed: () {
                // TODO: forgot password action
              },
              child: const Text("Forgot Password"),
            ),
          ],
        ),
      ],
    );
  }
}