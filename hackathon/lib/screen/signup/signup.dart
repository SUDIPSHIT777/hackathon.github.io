import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon/screen/signup/authwrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hackathon/screen/bottomNav/bottom_nav.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  static const Color backgroundColor = Color(0xFF060E17);
  static const Color cardColor = Color(0xFF0F1A24);
  static const Color inputFillColor = Color(0xFF132230);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF7E92A2);
  static const Color textAccent = Color(0xFF00FFC2);

  static const List<Color> buttonGradient = [
    Color(0xFF00C9A7),
    Color(0xFF047857),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
Future<void> signUpUser() async {
  final name = _nameController.text.trim();
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();
  final confirmPassword =
      _confirmPasswordController.text.trim();

  if (name.isEmpty) {
    showError("Please enter your full name");
    return;
  }

  if (name.length < 3) {
    showError("Name must be at least 3 characters");
    return;
  }

  if (email.isEmpty) {
    showError("Please enter your email");
    return;
  }

  if (!isValidEmail(email)) {
    showError("Please enter a valid email");
    return;
  }

  if (password.isEmpty) {
    showError("Please enter your password");
    return;
  }

  if (password.length < 6) {
    showError("Password must be at least 6 characters");
    return;
  }

  if (confirmPassword.isEmpty) {
    showError("Please confirm your password");
    return;
  }

  if (password != confirmPassword) {
    showError("Passwords do not match");
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final success =
        await context.read<AuthController>().signUp(
          name: name,
          email: email,
          password: password,
        );

    if (!mounted) return;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const BottomNav(),
        ),
        (route) => false,
      );
    } else {
      showError("Unable to create account");
    }
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}@override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              const Text(
                'Create Account 🚀',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Join us and start your coding journey today',
                textAlign: TextAlign.center,
                style: TextStyle(color: textSecondary),
              ),

              const SizedBox(height: 25),

              Container(
                height: screenSize.height * .15,
                width: screenSize.height * .15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: textAccent, width: 2),
                  image: const DecorationImage(
                    image: AssetImage('assets/codingImage.jpg.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _buildTextField(
                controller: _nameController,
                hintText: 'Full Name',
                prefixIcon: Icons.person_outline,
              ),

              const SizedBox(height: 15),

              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
              ),

              const SizedBox(height: 15),

              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                isObscured: _isPasswordObscured,
                onSuffixPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              ),

              const SizedBox(height: 15),

              _buildTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                isObscured: _isConfirmPasswordObscured,
                onSuffixPressed: () {
                  setState(() {
                    _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                  });
                },
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: buttonGradient),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : signUpUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: backgroundColor)
                      : const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: textSecondary),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: textAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    bool isObscured = false,
    VoidCallback? onSuffixPressed,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscured,
      style: const TextStyle(color: textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: textSecondary),
        prefixIcon: Icon(prefixIcon, color: textSecondary),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: textSecondary,
                ),
                onPressed: onSuffixPressed,
              )
            : null,
        filled: true,
        fillColor: inputFillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
  

  bool isValidEmail(String email) {
  return RegExp(
    r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
  ).hasMatch(email);
}

bool isValidPassword(String password) {
  return password.length >= 6;
}

void showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
}
