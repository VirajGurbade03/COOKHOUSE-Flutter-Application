import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // State to manage password visibility
  String? _errorMessage; // State to manage error messages

  Future<void> _signIn() async {
    try {
      // Sign in with Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save the email ID using shared_preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', _emailController.text.trim());

      // Navigate to the Homepage on successful sign-in
      Get.offAllNamed('/Homepage');
    } catch (e) {
      setState(() {
        _errorMessage = e.toString(); // Set the error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: AlignmentDirectional(-0.8, 0),
              child: Text(
                "Sign in",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 61.83,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.9, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: 282,
                  height:
                      2, // Set the height of the container to make it look like a line
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  SizedBox(
                    width: 374.52,
                    height: 69.91,
                    child: CupertinoTextField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.left,
                      placeholder: "Enter your email",
                      placeholderStyle:
                          const TextStyle(color: Color(0x66221F1F)),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: Icon(
                          CupertinoIcons.mail_solid,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 374.52,
                    height: 69.91,
                    child: CupertinoTextField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.left,
                      placeholder: "Enter your password",
                      obscureText: _obscureText,
                      obscuringCharacter: "*",
                      placeholderStyle:
                          const TextStyle(color: Color(0x66221F1F)),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: Icon(
                          CupertinoIcons.lock_fill,
                          color: Colors.grey,
                        ),
                      ),
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText =
                                  !_obscureText; // Toggle password visibility
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 10),
                    const Text(
                      "Entered Email or Password is incorrect.",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 374.52,
              height: 69.91,
              child: CupertinoButton(
                color: const Color(0xFF5F5F5F),
                borderRadius: BorderRadius.circular(39.95),
                onPressed: _signIn,
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                CupertinoButton(
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 197, 143, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(
                        '/Signup'); // Navigate to SignUp page on button press
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
