import 'package:flutter/material.dart';
import 'package:hackathon/screen/bottomNav/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordObscured = true;
  bool _isLoading = false; // Add this state variable to track loading
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Color Palette from UI
  static const Color backgroundColor = Color(0xFF060E17);
  static const Color cardColor = Color(0xFF0F1A24);
  static const Color inputFillColor = Color(0xFF132230);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF7E92A2);
  static const Color textAccent = Color(0xFF00FFC2); // Mint green accent

  // Gradient Colors for Login Button
  static const List<Color> buttonGradient = [
    Color(0xFF00C9A7),
    Color(0xFF047857),
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      // Back Button Align
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: textPrimary,
                          ),
                          onPressed: () {},
                        ),
                      ),

                      // Header Section
                      const Text(
                        'Welcome Back! 👋',
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
                        'Login to continue your\ncareer journey',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Central Illustration Asset
                      Center(
                        child: Container(
                          height: screenSize.height * 0.22,
                          width: screenSize.height * 0.22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cardColor,
                            border: Border.all(
                              color: const Color(0xFF162A3D),
                              width: 1.5,
                            ),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/codingImage.jpg.jpeg"),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: textAccent.withOpacity(0.12),
                                blurRadius: 40,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email or University ID Input
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

                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: textAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Login Button
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
                          // Disable button if loading
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text
                                      .trim();

                                  if (email.isNotEmpty && password.isNotEmpty) {
                                    // 1. Set loading state to true
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    // 2. Simulate 2-second delay (API call simulation)
                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                    );

                                    // 3. Save SharedPreferences
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setBool('isLoggedIn', true);
                                    if (!context.mounted) return;

                                    // 4. Navigate
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const BottomNav(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please enter both Email and Password',
                                        ),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          // Conditionally show loader or text
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: backgroundColor,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: backgroundColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Divider
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Color(0xFF1E2D3D),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'or continue with',
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xFF1E2D3D),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Expanded(child: SizedBox(height: 24)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Sign Up',
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
                    ],
                  ),
                ),
              ),
            );
          },
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
