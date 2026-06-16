import 'package:flutter/material.dart';
import 'package:hackathon/screen/bottomNav/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Color Palette matching your Login Screen
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        // CustomScrollView is the ultimate fix for form overflows
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  // Back Button Align

                  // Header Section
                  const Text(
                    'Create Account 🚀',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Join us and start your\ncoding journey today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Circular Masked Image
                  Center(
                    child: Container(
                      height: screenSize.height * 0.15,
                      width: screenSize.height * 0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cardColor,
                        border: Border.all(
                          color: textAccent.withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: textAccent.withOpacity(0.15),
                            blurRadius: 30,
                            spreadRadius: 2,
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/codingImage.jpg.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Full Name Input
                  _buildTextField(
                    controller: _nameController,
                    hintText: 'Full Name',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),

                  // Email Input
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email or University ID',
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 16),

                  // Password Input
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
                  const SizedBox(height: 16),

                  // Confirm Password Input
                  _buildTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock_reset_outlined,
                    isPassword: true,
                    isObscured: _isConfirmPasswordObscured,
                    onSuffixPressed: () {
                      setState(() {
                        _isConfirmPasswordObscured =
                            !_isConfirmPasswordObscured;
                      });
                    },
                  ),
                  const SizedBox(height: 32),

                  // Sign Up Button
                  Container(
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: buttonGradient,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: buttonGradient[0].withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        final name = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        final confirmPassword = _confirmPasswordController.text
                            .trim();

                        // 1. Basic Validation
                        if (name.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            confirmPassword.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all fields'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);

                        // Optional: You could also save the user's name or email here
                        // await prefs.setString('userName', name);

                        // 3. Check context before navigating
                        if (!context.mounted) return;

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNav(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),

            // SliverFillRemaining pushes the bottom content to the very bottom
            // of the screen, but allows everything to scroll cleanly when needed.
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: textSecondary, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: textAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Component Helper: TextFields
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
      style: const TextStyle(color: textPrimary, fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
        prefixIcon: Icon(prefixIcon, color: textSecondary, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: textSecondary,
                  size: 20,
                ),
                onPressed: onSuffixPressed,
              )
            : null,
        filled: true,
        fillColor: inputFillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF162A3D), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: textAccent, width: 1.5),
        ),
      ),
    );
  }
}
