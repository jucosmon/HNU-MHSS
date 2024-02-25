import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/components/my_button.dart';
import 'package:mentalhealth_support_system/components/my_text_field.dart';
import 'package:mentalhealth_support_system/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String? validateEmail(String? value) {
    if (value != null) {
      if (!value.endsWith("@hnu.edu.ph")) {
        return 'Please enter a valid email ending with @hnu.edu.ph';
      }
    } else {
      return 'Please enter an email';
    }
    return null;
  }

  // Sign up user
  void signUp() async {
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
        ),
      );
      return;
    }

    // Validate email
    String? emailValidationResult = validateEmail(emailController.text.trim());
    if (emailValidationResult != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailValidationResult),
        ),
      );
      return;
    }

    // Get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        'student',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    // Sign up message
                    const Text(
                      "Create an account!",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 35),

                    // First name textfield
                    MyTextField(
                      controller: firstNameController,
                      hintText: "First Name",
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),

                    // Last name textfield
                    MyTextField(
                      controller: lastNameController,
                      hintText: "Last Name",
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),

                    // Email textfield with validation
                    EmailTextField(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                      validator: validateEmail, // Add email validation
                    ),
                    const SizedBox(height: 10),

                    // Password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    // Confirm password textfield
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 25),

                    // Sign up button
                    MyButton(onTap: signUp, text: "Sign Up"),

                    const SizedBox(height: 25),

                    // Login if already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Login here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const EmailTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
