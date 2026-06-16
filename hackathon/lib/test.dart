import 'package:flutter/material.dart';

class ResumeAnalysisResultsScreen extends StatefulWidget {
  const ResumeAnalysisResultsScreen({super.key});

  @override
  State<ResumeAnalysisResultsScreen> createState() =>
      _ResumeAnalysisResultsScreenState();
}

class _ResumeAnalysisResultsScreenState
    extends State<ResumeAnalysisResultsScreen> {
  int _activeTabIdx = 0;

  // Color Specs Sampled Directly from image_3eca7a.jpg
  static const Color colorBg = Color(0xFF060E1A);
  static const Color colorCardBg = Color(0xFF0C1929);
  static const Color colorTextWhite = Colors.white;
  static const Color colorTextMuted = Color(0xFF7D8E9F);

  static const Color colorMint = Color(0xFF00D2A0);
  static const Color colorRedAccent = Color(0xFFEF4444);
  static const Color colorBlueAccent = Color(0xFF3B82F6);

  static const Color colorTabBg = Color(0xFF0D1724);
  static const Color colorTabActiveBg = Color(0xFF1E2D4A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorTextWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Resume Analysis',
          style: TextStyle(
            color: colorTextWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          // Theme Toggle Switch Mimic
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: colorTabBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.dark_mode_outlined,
                  size: 16,
                  color: colorTextMuted,
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B5CF6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.light_mode,
                    size: 14,
                    color: colorTextWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWideScreen = constraints.maxWidth > 650;
            final double horizontalPadding = isWideScreen ? 48.0 : 16.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    // --- SEGMENTED TOP SUB-HEADER NAVIGATION BAR ---
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 8.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: colorTabBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildSubTab(0, 'Overview'),
                              _buildSubTab(1, 'Detailed Result'),
                              _buildSubTab(2, 'Step-by-Step'),
                              _buildSubTab(3, 'Summary'),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // --- SCROLLABLE MAIN BODY ANALYSIS ---
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. OVERALL SCORE CARD
                            _buildOverallScoreCard(),
                            const SizedBox(height: 24),

                            // 2. CRITICAL GAPS SECTION
                            _buildSectionHeader(
                              'Critical Gaps',
                              colorRedAccent,
                            ),
                            const SizedBox(height: 12),
                            _buildGapsCard(),
                            const SizedBox(height: 24),

                            // 3. KEY STRENGTHS SECTION
                            _buildSectionHeader(
                              'Key Strengths',
                              colorBlueAccent,
                            ),
                            const SizedBox(height: 12),
                            _buildStrengthsCard(),
                            const SizedBox(height: 24),

                            // 4. STEP-BY-STEP OPTIMIZATION
                            _buildSectionHeader(
                              'Step-by-Step Optimization',
                              colorMint,
                            ),
                            const SizedBox(height: 12),
                            _buildOptimizationStepsList(),
                            const SizedBox(height: 24),

                            // 5. BOTTOM GRID METRICS (AI Recommendations & Market Match)
                            isWideScreen
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: _buildAiRecommendationCard(),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(child: _buildMarketMatchCard()),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      _buildAiRecommendationCard(),
                                      const SizedBox(height: 12),
                                      _buildMarketMatchCard(),
                                    ],
                                  ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),

                    // --- STICKY FOOTER ACTION BUTTONS ---
                    _buildStickyFooterBar(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Sub-Tab Segment Item Generator
  Widget _buildSubTab(int index, String label) {
    final bool isSelected = _activeTabIdx == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTabIdx = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colorTabActiveBg : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? colorTextWhite : colorTextMuted,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Section Header Indicator Bar decoration
  Widget _buildSectionHeader(String title, Color leftBarColor) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: leftBarColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: colorTextWhite,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Composite View Widgets matching your reference image layout specs:
  Widget _buildOverallScoreCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Overall Score',
                  style: TextStyle(color: colorTextMuted, fontSize: 14),
                ),
                SizedBox(height: 6),
                Text(
                  '85/100',
                  style: TextStyle(
                    color: colorTextWhite,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Great job! Your resume looks strong.',
                  style: TextStyle(color: colorTextMuted, fontSize: 13),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                width: 84,
                height: 84,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 7,
                  backgroundColor: Color(0xFF112237),
                  valueColor: AlwaysStoppedAnimation<Color>(colorMint),
                ),
              ),
              Text(
                '85',
                style: const TextStyle(
                  color: colorMint,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGapsCard() {
    return Container(
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildRowItem(
            Icons.info,
            colorRedAccent,
            'Native Development',
            'Lacks experience in Kotlin and Swift.',
          ),
          const Divider(color: Color(0xFF142438), height: 1),
          _buildRowItem(
            Icons.info,
            colorRedAccent,
            'CI/CD Knowledge',
            'No experience with CI/CD pipelines.',
          ),
        ],
      ),
    );
  }

  Widget _buildStrengthsCard() {
    return Container(
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildRowItem(
            Icons.check_circle,
            colorBlueAccent,
            'Flutter Expertise',
            'Proficient in Flutter SDK and Dart.',
          ),
          const Divider(color: Color(0xFF142438), height: 1),
          _buildRowItem(
            Icons.check_circle,
            colorBlueAccent,
            'API Integration',
            'Skilled in RESTful APIs and Firebase.',
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationStepsList() {
    final List<String> steps = [
      'Learn Kotlin and Swift.',
      'Gain CI/CD pipeline experience.',
      'Expand knowledge in native development.',
      'Enhance project management skills.',
    ];
    return Container(
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: steps.asMap().entries.map((entry) {
          int idx = entry.key;
          String text = entry.value;
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorMint.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.double_arrow_rounded,
                    color: colorMint,
                    size: 14,
                  ),
                ),
                title: Text(
                  text,
                  style: const TextStyle(color: colorTextWhite, fontSize: 14),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: colorTextMuted,
                  size: 18,
                ),
                onTap: () {},
              ),
              if (idx != steps.length - 1)
                const Divider(color: Color(0xFF142438), height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAiRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2D4A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.psychology_outlined,
                  color: Colors.blueAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'AI Recommendation',
                style: TextStyle(
                  color: colorTextWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Enhance skills in native mobile development and CI/CD.',
            style: TextStyle(color: colorTextMuted, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketMatchCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F2E28),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.trending_up,
                      color: colorMint,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Market Match',
                    style: TextStyle(
                      color: colorTextWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F2E28),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'High',
                  style: TextStyle(
                    color: colorMint,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'High demand for Flutter developers in mobile app industry.',
            style: TextStyle(color: colorTextMuted, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyFooterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: colorBg,
        border: Border(top: BorderSide(color: Color(0xFF101B2B), width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF4D6FFF), Color(0xFF8B5CF6)],
              ),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.upload_outlined,
                color: colorTextWhite,
                size: 20,
              ),
              label: const Text(
                'Upload New Resume',
                style: TextStyle(
                  color: colorTextWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Row Item Builder for Gaps and Strengths
  Widget _buildRowItem(
    IconData icon,
    Color iconColor,
    String title,
    String subTitle,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: colorTextWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subTitle,
                  style: const TextStyle(color: colorTextMuted, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
