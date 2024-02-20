import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/components/my_button.dart';
import 'package:mentalhealth_support_system/components/my_text_field.dart';
import 'package:mentalhealth_support_system/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in user
  void signIn() async {
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
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
                    //logo
                    const Icon(
                      Icons.message,
                      size: 100,
                    ),
                    const SizedBox(height: 50),

                    //welcome back message
                    const Text(
                      "Welcome Back Holynamian!",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),
                    //password textfield
                    MyTextField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false),
                    const SizedBox(height: 10),
                    MyTextField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true),

                    const SizedBox(height: 25),

                    //sign in button
                    MyButton(
                      onTap: signIn,
                      text: "Sign in",
                    ),

                    const SizedBox(height: 50),

                    //register if not yet signed up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not registered yet?"),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Register now",
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
