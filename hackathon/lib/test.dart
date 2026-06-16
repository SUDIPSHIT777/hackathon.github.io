import 'package:flutter/material.dart';

class ResumeAnalysisScreen extends StatelessWidget {
  const ResumeAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exact colors extracted from the Resume Analysis panel in WhatsApp Image 2026-06-16 at 10.01.46 AM.jpeg
    const backgroundColor = Color(0xFF07111E);
    const cardBackgroundColor = Color(0xFF0D1E32);
    const textMutedColor = Color(0xFF7E8F9F);
    const textWhiteColor = Colors.white;
    const mintGreenColor = Color(0xFF00D2A0);
    const badgeBgColor = Color(0xFF13233A);
    const badgeTextColor = Color(0xFF94A9FF);

    // Bottom button gradient
    final uploadButtonGradient = [
      const Color(0xFF3B5CF6),
      const Color(0xFF8B5CF6),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textWhiteColor),
          onPressed: () {
            // Handle back navigation
          },
        ),
        title: const Text(
          'Resume Analysis',
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
            // Adaptive horizontal padding for wider screens (tablets/web)
            double horizontalPadding = constraints.maxWidth > 600 ? 64.0 : 20.0;
            double maxContentWidth = 480.0;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),

                              // --- OVERALL SCORE CARD ---
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: cardBackgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    // Scores Text Frame
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Overall Score',
                                            style: TextStyle(
                                              color: textMutedColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                '85',
                                                style: TextStyle(
                                                  color: textWhiteColor,
                                                  fontSize:
                                                      constraints.maxWidth > 360
                                                      ? 40
                                                      : 34,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Text(
                                                '/100',
                                                style: TextStyle(
                                                  color: textMutedColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            'Great job! Your resume looks strong.',
                                            style: TextStyle(
                                              color: textMutedColor,
                                              fontSize: 13,
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Circular Custom Ring Indicator
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: CircularProgressIndicator(
                                            value: 0.85,
                                            strokeWidth: 8,
                                            backgroundColor: const Color(
                                              0xFF14293F,
                                            ),
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                  Color
                                                >(mintGreenColor),
                                          ),
                                        ),
                                        const Text(
                                          '85',
                                          style: TextStyle(
                                            color: mintGreenColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              // --- STRENGTHS SECTION ---
                              const Text(
                                'Strengths',
                                style: TextStyle(
                                  color: textWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  _buildBadge(
                                    'Education',
                                    badgeBgColor,
                                    badgeTextColor,
                                  ),
                                  _buildBadge(
                                    'Skills',
                                    badgeBgColor,
                                    badgeTextColor,
                                  ),
                                  _buildBadge(
                                    'Project Experience',
                                    badgeBgColor,
                                    badgeTextColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 28),

                              // --- AREAS TO IMPROVE SECTION ---
                              const Text(
                                'Areas to Improve',
                                style: TextStyle(
                                  color: textWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Improvement Points List
                              _buildImprovementItem(
                                text: 'Add more achievements',
                                dotColor: const Color(0xFFEF4444), // Coral Red
                                textColor: textMutedColor,
                              ),
                              const SizedBox(height: 16),
                              _buildImprovementItem(
                                text: 'Include keywords for ATS',
                                dotColor: const Color(
                                  0xFF8B5CF6,
                                ), // Soft Violet
                                textColor: textMutedColor,
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),

                      // --- BOTTOM ACTIONS: UPLOAD NEW RESUME BUTTON ---
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          height: 54,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: uploadButtonGradient,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              // Perform file selection layout context execution
                            },
                            child: const Text(
                              'Upload New Resume',
                              style: TextStyle(
                                color: textWhiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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

  // Helper builder logic to design pill-shaped chips
  Widget _buildBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: text,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Helper builder layout to maintain cleaner custom bullets for improvement recommendations
  Widget _buildImprovementItem({
    required String text,
    required Color dotColor,
    required Color textColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: dotColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}