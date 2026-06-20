import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  // --- SHARED COLOR PALETTE (matches ProfileScreen) ---
  static const Color backgroundColor = Color(0xFF051429);
  static const Color cardBackgroundColor = Color(0xFF0E223D);
  static const Color textWhiteColor = Colors.white;
  static const Color textMutedColor = Color(0xFF8A9EAD);
  static const Color actionIconColor = Color(0xFF6C8299);
  static const Color borderStrokeColor = Color(0xFF1E324A);
  static const Color accentColor = Color(0xFF00D2A0);
  static const Color iconBgColor = Color(0xFF162D4A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textWhiteColor,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "ABOUT US",
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // --- APP ICON / LOGO ---
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
                        Icons.explore_rounded,
                        size: 54,
                        color: accentColor.withOpacity(0.85),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- APP NAME & TAGLINE ---
                  const Text(
                    'Career Compass',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textWhiteColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Campus Career Navigator',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textMutedColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: accentColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- ABOUT SECTION ---
                  _sectionLabel('About the App'),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderStrokeColor, width: 1),
                    ),
                    child: const Text(
                      'Career Compass is an AI-powered career guidance platform designed to help students make informed academic and professional decisions. It provides personalized career exploration, degree recommendations, resume analysis, internship discovery, goal tracking, and AI-powered mentorship — all in one place.',
                      style: TextStyle(
                        color: textMutedColor,
                        fontSize: 14,
                        height: 1.65,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- KEY FEATURES CARD ---
                  _sectionLabel('Key Features'),
                  const SizedBox(height: 10),
                  _buildMenuCard([
                    _RowData(
                      Icons.explore_rounded,
                      'Career Discovery',
                      'Degree recommendations tailored to you',
                    ),
                    _RowData(
                      Icons.description_rounded,
                      'Resume Analysis',
                      'Skill gap assessment & feedback',
                    ),
                    _RowData(
                      Icons.work_outline_rounded,
                      'Internship Finder',
                      'Discover opportunities near you',
                    ),
                    _RowData(
                      Icons.flag_rounded,
                      'Goal Tracker',
                      'Set and monitor your milestones',
                    ),
                    _RowData(
                      Icons.chat_bubble_outline_rounded,
                      'AI Career Advisor',
                      'Personalised guidance, anytime',
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // --- TECH STACK CARD ---
                  // _sectionLabel('Technology Stack'),
                  // const SizedBox(height: 10),
                  // _buildMenuCard([
                  //   _RowData(
                  //     Icons.phone_android_rounded,
                  //     'Flutter & Dart',
                  //     'Cross-platform mobile framework',
                  //   ),
                  //   _RowData(
                  //     Icons.cloud_rounded,
                  //     'Firebase',
                  //     'Auth, Firestore & cloud services',
                  //   ),
                  //   _RowData(
                  //     Icons.settings_rounded,
                  //     'GetX',
                  //     'State management & navigation',
                  //   ),
                  //   _RowData(
                  //     Icons.smart_toy_rounded,
                  //     'AI Engine',
                  //     'Powered by large language models',
                  //   ),
                  // ]),
                  // const SizedBox(height: 24),

                  // --- TEAM CARD ---
                  _sectionLabel('Developed By'),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderStrokeColor, width: 1),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: iconBgColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.groups_rounded,
                                  color: accentColor,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 14),
                              const Text(
                                'Developer teams',
                                style: TextStyle(
                                  color: textWhiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            color: borderStrokeColor.withOpacity(0.6),
                            height: 1,
                          ),
                        ),
                        _buildTeamMemberRow(
                          'Gourab Giri (Team leader)',
                          'Flutter Developer',
                          isLast: false,
                        ),
                        _buildTeamMemberRow(
                          'Sudip Kumar Shit',
                          'Flutter Developer',
                          isLast: false,
                        ),
                        _buildTeamMemberRow(
                          'Sanjoy Singha',
                          'Multimedia Designer',
                          isLast: false,
                        ),
                        _buildTeamMemberRow(
                          'Sourav Bera',
                          'UI/UX Developer',
                          isLast: false,
                        ),

                        _buildTeamMemberRow(
                          'Debarati Maity',
                          'UI/UX Designer',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // --- VISION CARD ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: accentColor.withOpacity(0.25),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.rocket_launch_rounded,
                            color: accentColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Our Vision',
                          style: TextStyle(
                            color: textWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'One Platform. One Roadmap.\nUnlimited Career Possibilities.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textMutedColor,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // // --- HACKATHON BADGE ---
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(20),
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xFF0E223D),
                  //     borderRadius: BorderRadius.circular(16),
                  //     border: Border.all(
                  //       color: const Color(0xFF1E3A5A),
                  //       width: 1,
                  //     ),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         padding: const EdgeInsets.all(12),
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xFFFFD700).withOpacity(0.12),
                  //           borderRadius: BorderRadius.circular(14),
                  //         ),
                  //         child: const Icon(
                  //           Icons.emoji_events_rounded,
                  //           color: Color(0xFFFFD700),
                  //           size: 28,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 16),
                  //       const Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             'Hackathon Project 2026',
                  //             style: TextStyle(
                  //               color: textWhiteColor,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 15,
                  //             ),
                  //           ),
                  //           SizedBox(height: 4),
                  //           Text(
                  //             'Built for RE_IMAGINE Season 2',
                  //             style: TextStyle(
                  //               color: textMutedColor,
                  //               fontSize: 13,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: textMutedColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<_RowData> rows) {
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderStrokeColor, width: 1),
      ),
      child: Column(
        children: List.generate(rows.length, (i) {
          final row = rows[i];
          final isLast = i == rows.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(row.icon, color: actionIconColor, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            row.title,
                            style: const TextStyle(
                              color: textWhiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (row.subtitle != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              row.subtitle!,
                              style: const TextStyle(
                                color: textMutedColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: borderStrokeColor.withOpacity(0.6),
                    height: 1,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTeamMemberRow(String name, String role, {required bool isLast}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: actionIconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: textWhiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      role,
                      style: const TextStyle(
                        color: textMutedColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: borderStrokeColor.withOpacity(0.6),
              height: 1,
            ),
          ),
      ],
    );
  }
}

class _RowData {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _RowData(this.icon, this.title, [this.subtitle]);
}
