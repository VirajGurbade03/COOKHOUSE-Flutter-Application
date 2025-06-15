import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comfortcast_1/src/fetures/model/user_model.dart';
import 'package:comfortcast_1/src/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  DateTime? _selectedDate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: _emailController.text,
        fullName: _nameController.text,
        password: _passwordController.text,
        phoneNo:
            int.tryParse(_phoneController.text) ?? 0, // Handle parsing errors
        dob: _selectedDate != null
            ? "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}"
            : "",
      );

      // Save user details to SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', _nameController.text);
      await prefs.setString('userEmail', _emailController.text);
      await prefs.setString('userPhone', _phoneController.text);

      UserRepository.instance.signUpWithEmail(
          _emailController.text, _passwordController.text, user);
      Navigator.pushNamed(context, "/Heightpage");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: height * 0.06), // 6% of screen height
                Align(
                  alignment: AlignmentDirectional(-0.7, 0),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.15, // 15% of screen width
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.9, 0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.08, vertical: 8),
                    child: Container(
                      width: width * 0.75,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04), // 4% of screen height
                _buildTextField(
                  controller: _nameController,
                  hintText: "Enter your full name",
                  icon: CupertinoIcons.person_crop_circle_fill_badge_checkmark,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your full name'
                      : null,
                ),
                SizedBox(height: height * 0.02), // 2% of screen height
                _buildTextField(
                  controller: _emailController,
                  hintText: "Enter your email",
                  icon: CupertinoIcons.mail_solid,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02), // 2% of screen height
                _buildTextField(
                  controller: _phoneController,
                  hintText: "Enter your Phone No.",
                  icon: CupertinoIcons.phone_fill,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02), // 2% of screen height
                _buildTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  icon: CupertinoIcons.lock_shield_fill,
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.done,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your password'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                SizedBox(height: height * 0.02), // 2% of screen height
                _buildDatePicker(),
                SizedBox(height: height * 0.02), // 2% of screen height
                _buildSignUpButton(),
                SizedBox(height: height * 0.017), // 1.7% of screen height
                _buildSignInPrompt(), // Added sign-in prompt
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.next,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Center(
      child: SizedBox(
        width: 0.9 * MediaQuery.of(context).size.width, // 90% of screen width
        height: 69.91,
        child: TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          textAlign: TextAlign.left,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0x66221F1F)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Icon(
                icon,
                color: Colors.grey,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then((date) {
            if (date != null) {
              setState(() {
                _selectedDate = date;
              });
            }
          });
        },
        child: Container(
          width: 0.9 * MediaQuery.of(context).size.width, // 90% of screen width
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  CupertinoIcons.calendar,
                  color: Colors.grey,
                ),
              ),
              Text(
                _selectedDate == null
                    ? 'Select your DOB'
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                style: const TextStyle(
                  color: Color(0x66221F1F),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: 0.9 * MediaQuery.of(context).size.width, // 90% of screen width
      height: 69.91,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF5F5F5F),
          borderRadius: BorderRadius.circular(39.95),
        ),
        child: TextButton(
          onPressed: _registerUser,
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/SignIn");
          },
          child: const Text(
            "Sign in",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
