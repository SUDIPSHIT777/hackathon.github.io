import 'package:flutter/material.dart';

class CareerPathReadyScreen extends StatelessWidget {
  const CareerPathReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exact color codes sampled from Step 4 of WhatsApp Image 2026-06-16 at 12.35.48 PM.jpeg
    const Color colorBg = Color(0xFF040B14);
    const Color colorCardBg = Color(0xFF0A1424);
    const Color colorTextWhite = Colors.white;
    const Color colorTextMuted = Color(0xFF6B7A90);
    const Color colorMint = Color(0xFF00D2A0);
    const Color colorBlue = Color(0xFF3B82F6);
    const Color colorBorderDefault = Color(0xFF13233A);

    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorTextWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWideScreen = constraints.maxWidth > 650;
            final double horizontalPadding = isWideScreen ? 48.0 : 20.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // --- TOP PROGRESS STEPPER (ALL STEPS COMPLETED) ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Step 4 of 4',
                                  style: TextStyle(
                                    color: colorTextMuted,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                _buildCompletedStepper(),
                              ],
                            ),
                            const SizedBox(height: 28),

                            // --- SUCCESS RADIAL VECTOR SHIELD ---
                            Center(
                              child: Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      colorBlue.withOpacity(0.2),
                                      Colors.transparent,
                                    ],
                                  ),
                                  border: Border.all(
                                    color: colorBlue.withOpacity(0.6),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: colorBlue,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // --- MAIN HEADERS ---
                            const Text(
                              'Your Career Path\nis Ready!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorTextWhite,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'We created the best career roadmap\nbased on your profile.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorTextMuted,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // --- SELECTION SUMMARY CARDS ROW ---
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSummaryBadge(
                                    'Stream',
                                    'Science',
                                    Icons.science_outlined,
                                    const Color(0xFF0F2447),
                                    colorBlue,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildSummaryBadge(
                                    'Course',
                                    'B.Tech Computer\nScience',
                                    Icons.code_rounded,
                                    const Color(0xFF092524),
                                    colorMint,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // --- MATCH SCORE SCORECARD ---
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorCardBg,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: colorBorderDefault),
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircularProgressIndicator(
                                          value: 0.92,
                                          strokeWidth: 5,
                                          backgroundColor: Color(0xFF112237),
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                colorBlue,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        '92%',
                                        style: TextStyle(
                                          color: colorTextWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Your Career Match Score',
                                          style: TextStyle(
                                            color: colorTextMuted,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: const [
                                            Text(
                                              'Excellent Match ',
                                              style: TextStyle(
                                                color: colorMint,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(
                                              Icons.star_rounded,
                                              color: Colors.amber,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          'You are on the right path!',
                                          style: TextStyle(
                                            color: colorTextMuted,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),

                            // --- TOP CAREER RECOMMENDATIONS ---
                            const Text(
                              'Top Career Recommendations',
                              style: TextStyle(
                                color: colorTextWhite,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildRecommendationItem(
                              1,
                              'Software Engineer',
                              '96% Match',
                              colorBlue,
                              colorCardBg,
                              colorBorderDefault,
                            ),
                            const SizedBox(height: 8),
                            _buildRecommendationItem(
                              2,
                              'Data Scientist',
                              '92% Match',
                              const Color(0xFF8B5CF6),
                              colorCardBg,
                              colorBorderDefault,
                            ),
                            const SizedBox(height: 8),
                            _buildRecommendationItem(
                              3,
                              'AI Engineer',
                              '89% Match',
                              Colors.amber,
                              colorCardBg,
                              colorBorderDefault,
                            ),
                            const SizedBox(height: 8),
                            _buildRecommendationItem(
                              4,
                              'Cyber Security Analyst',
                              '85% Match',
                              colorMint,
                              colorCardBg,
                              colorBorderDefault,
                            ),
                            const SizedBox(height: 28),

                            // --- 4-YEAR ROADMAP PREVIEW ---
                            const Text(
                              'Your 4-Year Roadmap Preview',
                              style: TextStyle(
                                color: colorTextWhite,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildTimelineRoadmap(
                              colorBorderDefault,
                              colorMuted: colorTextMuted,
                              colorWhite: colorTextWhite,
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),

                    // --- ACTIONS FOOTER LAYER ACTION BUTTONS ---
                    _buildFooterActions(colorTextWhite, colorTextMuted),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Completed Step design engine
  Widget _buildCompletedStepper() {
    return Row(
      children: List.generate(4, (index) {
        return Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0xFF00D2A0),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.check, color: Colors.white, size: 10),
              ),
            ),
            if (index != 3)
              Container(width: 14, height: 1.5, color: const Color(0xFF00D2A0)),
          ],
        );
      }),
    );
  }

  // Dynamic Horizontal selection metadata tracker helper
  Widget _buildSummaryBadge(
    String tag,
    String label,
    IconData icon,
    Color bg,
    Color accent,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1424),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF13233A)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tag,
                  style: const TextStyle(
                    color: Color(0xFF6B7A90),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Row tile decorator helper for list entries
  Widget _buildRecommendationItem(
    int num,
    String role,
    String percent,
    Color badgeColor,
    Color bg,
    Color border,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '$num',
                style: TextStyle(
                  color: badgeColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              role,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            percent,
            style: const TextStyle(
              color: Color(0xFF00D2A0),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF33475E),
            size: 16,
          ),
        ],
      ),
    );
  }

  // Custom Horizontal Timeline Builder matching Roadmap preview node structures
  Widget _buildTimelineRoadmap(
    Color dividerColor, {
    required Color colorMuted,
    required Color colorWhite,
  }) {
    final List<Map<String, String>> timelineData = [
      {
        'year': 'Year 1',
        'focus': 'Learn\nFundamentals',
        'iconBg': '0xFF0F2447',
        'iconColor': '0xFF3B82F6',
        'icon': 'Icons.school_outlined',
      },
      {
        'year': 'Year 2',
        'focus': 'Build\nProjects',
        'iconBg': '0xFF1B1938',
        'iconColor': '0xFF8B5CF6',
        'icon': 'Icons.architecture',
      },
      {
        'year': 'Year 3',
        'focus': 'Internship\n& Experience',
        'iconBg': '0xFF08243A',
        'iconColor': '0xFF00A2E8',
        'icon': 'Icons.business_center_outlined',
      },
      {
        'year': 'Year 4',
        'focus': 'Placement\nPreparation',
        'iconBg': '0xFF0C251F',
        'iconColor': '0xFF10B981',
        'icon': 'Icons.gavel_outlined',
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: timelineData.asMap().entries.map((entry) {
        int idx = entry.key;
        var data = entry.value;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: idx == 0 ? Colors.transparent : dividerColor,
                      thickness: 1,
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color(int.parse(data['iconBg']!)),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(
                          int.parse(data['iconColor']!),
                        ).withOpacity(0.4),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        idx == 0
                            ? Icons.school_outlined
                            : idx == 1
                            ? Icons.star_border
                            : idx == 2
                            ? Icons.business_center_outlined
                            : Icons.assignment_ind_outlined,
                        color: Color(int.parse(data['iconColor']!)),
                        size: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: idx == timelineData.length - 1
                          ? Colors.transparent
                          : dividerColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                data['year']!,
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data['focus']!,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorMuted, fontSize: 10, height: 1.3),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Footer Button row architecture configuration
  Widget _buildFooterActions(Color textWhite, Color textMuted) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF007BFF), Color(0xFF0052D4)],
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Detailed Roadmap',
                    style: TextStyle(
                      color: textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: textWhite, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.download_outlined, color: textMuted, size: 18),
                label: Text(
                  'Download Report',
                  style: TextStyle(
                    color: textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.grid_view_rounded, color: textMuted, size: 16),
                label: Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    color: textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}