import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF060E19);
    const Color cardBackgroundColor = Color(0xFF0C1929);
    const Color textWhiteColor = Colors.white;
    const Color textMutedColor = Color(0xFF7E8F9F);
    const Color borderStrokeColor = Color(0xFF142539);
    const Color accentCyanColor = Color(0xFF00D2C4);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textWhiteColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Privacy Policy',
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
                constraints: const BoxConstraints(maxWidth: 650),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Last Updated Header Card ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBackgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderStrokeColor),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.verified_user_rounded,
                              color: accentCyanColor,
                              size: 28,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'We care about your privacy',
                                    style: TextStyle(
                                      color: textWhiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Last updated: June 2026',
                                    style: TextStyle(
                                      color: textMutedColor.withOpacity(0.8),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // --- Introduction Text ---
                      Text(
                        'Your privacy is critical to us. This privacy policy document outlines the types of personal information received, collected, and how it is used across our dashboard and app utilities.',
                        style: TextStyle(
                          color: textMutedColor,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: borderStrokeColor),
                      const SizedBox(height: 16),

                      // --- Policy Sections ---
                      _buildPolicySection(
                        title: '1. Information We Collect',
                        content:
                            'We only collect fundamental identity elements explicitly provided by you, such as name, email, university details, or professional portfolio parameters. No background automated device logging occurs without permission.',
                        textColor: textWhiteColor,
                        mutedColor: textMutedColor,
                      ),
                      _buildPolicySection(
                        title: '2. How We Use Information',
                        content:
                            'The provided data strictly processes personalized recommendations tailored to individual preferences, secure authentication pipelines, profile verification status updates, and interactive user state calculation routines.',
                        textColor: textWhiteColor,
                        mutedColor: textMutedColor,
                      ),
                      _buildPolicySection(
                        title: '3. Data Storage & Local Persistence',
                        content:
                            'Key session flags are safely locked into local system device persistence nodes (like SharedPreferences storage configurations). This helps preserve chosen UI theme parameters and current authorization sessions directly on your hardwire device architecture.',
                        textColor: textWhiteColor,
                        mutedColor: textMutedColor,
                      ),
                      _buildPolicySection(
                        title: '4. Third-Party Distribution Safeguards',
                        content:
                            'We hold absolute zero monetization strategies based on user telemetry transmission records. Your records are never parsed, rented, sold, or shared out to global marketing engines, analytics, or enterprise ad aggregators.',
                        textColor: textWhiteColor,
                        mutedColor: textMutedColor,
                      ),
                      _buildPolicySection(
                        title: '5. Policy Amendments & Updates',
                        content:
                            'We preserve systemic permissions to alter layout terms within this document. Users can evaluate changes directly by checking the live historical timestamp indicator managed at the top section row of this layout screen viewport layer.',
                        textColor: textWhiteColor,
                        mutedColor: textMutedColor,
                      ),

                      const SizedBox(height: 12),
                      const Divider(color: borderStrokeColor),
                      const SizedBox(height: 24),

                      // --- Footer Contact Card ---
                      Center(
                        child: Text(
                          'Have questions? Contact support via support@app.com',
                          style: TextStyle(
                            color: textMutedColor.withOpacity(0.6),
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
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

  Widget _buildPolicySection({
    required String title,
    required String content,
    required Color textColor,
    required Color mutedColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(color: mutedColor, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}