import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;


  void onRegister() async {
    if (_formKey.currentState!.validate()) {

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        "user_name",
        "${firstNameController.text} ${lastNameController.text}",
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registered")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8E7),
      body: SafeArea(
        child: Column(
          children: [

            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text("Back"),
              ],
            ),

            const Text(
              "Create Account 👨‍🍳",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [

                      field(firstNameController, "First Name"),
                      const SizedBox(height: 15),

                      field(lastNameController, "Last Name"),
                      const SizedBox(height: 15),

                      field(emailController, "Email"),
                      const SizedBox(height: 15),

                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: input(
                          "Password",
                          Icons.lock,
                          suffix: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password required";
                          }
                          if (value.length < 6) {
                            return "Min 6 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onRegister,
                          child: const Text("Sign Up"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget field(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: input(hint, Icons.person),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hint required";
        }
        return null;
      },
    );
  }

  InputDecoration input(String hint, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}