import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/about/about_screen.dart';
import 'package:hackathon/screen/login/login.dart';
import 'package:hackathon/screen/privecy_policy.dart';
import 'package:hackathon/screen/signup/authwrapper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final userName = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : "User";

    final userEmail = user?.email ?? "No Email";

    // --- UI COLOR PALETTE ---
    const Color backgroundColor = Color(0xff051429);
    const Color cardBackgroundColor = Color(
      0xFF0E223D,
    ); // Slightly lighter for card depth
    const Color textWhiteColor = Colors.white;
    const Color textMutedColor = Color(0xFF8A9EAD);
    const Color actionIconColor = Color(0xFF6C8299);
    const Color borderStrokeColor = Color(0xFF1E324A);
    const Color accentColor = Color(0xFF00D2A0);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "PROFILE",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),

        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWideDisplay = constraints.maxWidth > 600;
            final double horizontalPadding = isWideDisplay ? 64.0 : 20.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),

                            // --- PREMIUM USER AVATAR WITH BADGE ---
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: accentColor.withOpacity(0.4),
                                        width: 2.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: accentColor.withOpacity(0.1),
                                          blurRadius: 16,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: cardBackgroundColor,
                                      child: Icon(
                                        Icons.person_rounded,
                                        size: 54,
                                        color: textMutedColor.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: accentColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: backgroundColor,
                                          width: 2.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      // child: const Icon(
                                      //   Icons.camera_alt_rounded,
                                      //   color: backgroundColor,
                                      //   size: 15,
                                      // ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // --- USER META DATA ---
                            Text(
                              userName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: textWhiteColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              userEmail,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: textMutedColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // --- SETTINGS & INFO MENU CARD ---
                            Container(
                              decoration: BoxDecoration(
                                color: cardBackgroundColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: borderStrokeColor,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  _buildMenuRow(
                                    Icons.privacy_tip_outlined,
                                    'Privacy Policy',
                                    actionIconColor,
                                    textWhiteColor,
                                    onTap: () {
                                      Get.to(() => PrivacyPolicyScreen());
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Divider(
                                      color: borderStrokeColor.withOpacity(0.6),
                                      height: 1,
                                    ),
                                  ),
                                  _buildMenuRow(
                                    Icons.settings_applications,
                                    'About App',
                                    actionIconColor,
                                    textWhiteColor,
                                    subtitle: 'About the',
                                    onTap: () {
                                      Get.to(() => AboutAppScreen());
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Divider(
                                      color: borderStrokeColor.withOpacity(0.6),
                                      height: 1,
                                    ),
                                  ),
                                  _buildMenuRow(
                                    Icons.info_outline_rounded,
                                    'Version Info',
                                    actionIconColor,
                                    textWhiteColor,
                                    subtitle: 'V.0.1',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // --- LOGOUT BUTTON CARD ---
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF2A1418,
                                ), // Subtle red tint background
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF5C2429),
                                  width: 1,
                                ),
                              ),
                              child: _buildMenuRow(
                                Icons.logout_rounded,
                                'Logout Account',
                                const Color(0xFFE63946),
                                const Color(0xFFE63946),
                                isDestructive: true,
                                onTap: () async {
                                  await context.read<AuthController>().logout();
                                  Get.offAll(() => const LoginScreen());
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A1418),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF5C2429),
                                  width: 1,
                                ),
                              ),
                              child: _buildMenuRow(
                                Icons.delete_forever_rounded,
                                'Delete Account',
                                Colors.red,
                                Colors.red,
                                isDestructive: true,
                                onTap: () => _deleteAccount(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // --- REFACTORED MENU ROW ---
  Widget _buildMenuRow(
    IconData icon,
    String title,
    Color leadingColor,
    Color textColor, {
    String? subtitle,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16),
      splashColor: isDestructive
          ? Color.fromARGB(20, 230, 57, 70)
          : const Color.fromARGB(26, 255, 255, 255),
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDestructive
                    ? const Color(0xFF3D1A1F)
                    : const Color(0xFF162D4A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: leadingColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF6C8299),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDestructive
                  ? const Color(0xFF8E3D43)
                  : const Color(0xFF4A5A6A),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _deleteAccount(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;
  final bool? confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Account"),
      content: const Text(
        "Are you sure you want to permanently delete your account?\n\n"
        "This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );

  if (confirm != true) return;

  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .delete()
        .catchError((_) {});

    // Delete Firebase Authentication account
    await user.delete();

    Get.snackbar(
      "Success",
      "Account deleted successfully",
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.offAll(() => const LoginScreen());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      Get.snackbar(
        "Re-login Required",
        "Please logout and login again before deleting your account.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Error",
        e.message ?? "Failed to delete account",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
  }
}
