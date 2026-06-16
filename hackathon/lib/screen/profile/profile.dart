import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hackathon/screen/login/login.dart';
import 'package:hackathon/screen/privecy_policy.dart';
import 'package:hackathon/screen/signup/authwrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xff051429);
    const Color cardBackgroundColor = Color.fromARGB(255, 19, 38, 60);

    const Color textWhiteColor = Colors.white;
    const Color textMutedColor = Color(0xFF7E8F9F);
    const Color actionIconColor = Color(0xFF5A6D82);
    const Color borderStrokeColor = Color(0xFF142539);
    const Color navActiveColor = Color(0xFF00D2A0);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: textWhiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
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
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),

                            // --- USER AVATAR WITH INTEGRATED BADGES ---
                            Center(
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF1C324E),
                                        width: 2,
                                      ),
                                    ),
                                    child: const CircleAvatar(
                                      radius: 46,
                                      child: Icon(Icons.person, size: 50),
                                      // backgroundImage: NetworkImage(
                                      //   'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=200',
                                      // ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: cardBackgroundColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: textMutedColor,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // --- USER META DATA DESCRIPTION NAMES ---
                            const Text(
                              'Sarah Ahmed',
                              style: TextStyle(
                                color: textWhiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Computer Science Student',
                              style: TextStyle(
                                color: textMutedColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Tech University',
                              style: TextStyle(
                                color: textMutedColor,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 28),

                            // --- STATS METRIC GRID SYSTEM ---
                            const SizedBox(height: 24),

                            // --- DASHBOARD ACTIONS MENU LIST ---
                            _buildMenuRow(
                              Icons.assignment_turned_in_outlined,
                              'Privecy policy',
                              actionIconColor,
                              textWhiteColor,
                              onTap: () {
                                Get.to(() => PrivacyPolicyScreen());
                              },
                            ),
                            _buildMenuRow(
                              Icons.settings_outlined,
                              'Version\n V.0.1',
                              actionIconColor,
                              textWhiteColor,
                            ),

                            // Divider before logout
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(color: borderStrokeColor),
                            ),

                            // --- LOGOUT BUTTON ---
                            _buildMenuRow(
                              Icons.logout_rounded,
                              'Logout',
                              const Color(0xFFE63946), // Red distinct color
                              const Color(0xFFE63946),
                              onTap: () async {
                                await context.read<AuthController>().logout();

                                Get.offAll(() => const LoginScreen());
                              },
                            ),
                            const SizedBox(height: 20),
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

  Widget _buildVerticalDivider(Color dividerColor) {
    return Container(width: 1, height: 32, color: dividerColor);
  }

  // --- UPDATED: Added an optional onTap parameter ---
  Widget _buildMenuRow(
    IconData icon,
    String title,
    Color leadingColor,
    Color textColor, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        leading: Icon(icon, color: leadingColor, size: 22),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF4A5A6A),
          size: 20,
        ),
        onTap:
            onTap ??
            () {
              // Default logic for other buttons if none is provided
            },
      ),
    );
  }
}
