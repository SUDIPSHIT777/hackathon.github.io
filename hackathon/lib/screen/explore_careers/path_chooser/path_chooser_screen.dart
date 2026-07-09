import 'package:flutter/material.dart';
import 'package:hackathon/screen/explore_careers/path_chooser/controller/path_chooser_controller.dart';
import 'package:provider/provider.dart';

class PathChooserScreen extends StatefulWidget {
  final String stream;
  final String degree;

  const PathChooserScreen({
    super.key,
    required this.stream,
    required this.degree,
  });

  @override
  State<PathChooserScreen> createState() => _PathChooserScreenState();
}

class _PathChooserScreenState extends State<PathChooserScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CareerPathController>().loadCareerPath(
        widget.stream,
        widget.degree,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Exact color codes sampled from Step 4 of WhatsApp Image 2026-06-16 at 12.35.48 PM.jpeg
    const Color colorBg = Color(0xff051429);
    const Color colorCardBg = Color.fromARGB(255, 19, 38, 60);
    const Color colorTextWhite = Colors.white;
    const Color colorTextMuted = Color(0xFF6B7A90);
    const Color colorMint = Color(0xFF00D2A0);
    const Color colorBlue = Color(0xFF3B82F6);
    const Color colorBorderDefault = Color(0xFF13233A);

    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorTextWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<CareerPathController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.data == null) {
            return const Center(
              child: Text(
                'No Data Found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final career = controller.data!;
          return SafeArea(
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
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     const Text(
                                //       'Step 4 of 4',
                                //       style: TextStyle(
                                //         color: colorTextMuted,
                                //         fontSize: 13,
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //     _buildCompletedStepper(),
                                //   ],
                                // ),
                                // const SizedBox(height: 28),

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
                                        widget.stream,
                                        Icons.science_outlined,
                                        const Color(0xFF0F2447),
                                        colorBlue,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildSummaryBadge(
                                        'Course',
                                        widget.degree,
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
                                    border: Border.all(
                                      color: colorBorderDefault,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: CircularProgressIndicator(
                                              value: career.matchScore / 100,
                                              strokeWidth: 5,
                                              backgroundColor: Color(
                                                0xFF112237,
                                              ),
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    colorBlue,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            '${career.matchScore}%',
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
                                              children: [
                                                Text(
                                                  career.matchLabel,
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
                                SizedBox(height: 10),
                                Column(
                                  children: career.careers
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8,
                                          ),
                                          child: _buildRecommendationItem(
                                            entry.key + 1,
                                            entry.value,
                                            // '${95 - (entry.key * 3)}% Match',
                                            [
                                              const Color(0xFF3B82F6),
                                              const Color(0xFF8B5CF6),
                                              Colors.amber,
                                              const Color(0xFF00D2A0),
                                            ][entry.key % 4],
                                            colorCardBg,
                                            colorBorderDefault,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
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
                                  career.roadmap,
                                  colorBorderDefault,
                                  colorMuted: colorTextMuted,
                                  colorWhite: colorTextWhite,
                                ),
                                const SizedBox(height: 24),
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
          );
        },
      ),
    );
  }
  // Completed Step design engine

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
    // String percent,
    Color badgeColor,
    Color bg,
    Color border,
  ) {
    return GestureDetector(
      onTap: () => CareerPathController.lunch(role),
      child: Container(
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
            // Text(
            //   percent,
            //   style: const TextStyle(
            //     color: Color(0xFF00D2A0),
            //     fontSize: 12,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_outward_outlined,
              color: Color(0xFF33475E),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Custom Horizontal Timeline Builder matching Roadmap preview node structures
  Widget _buildTimelineRoadmap(
    List<String> roadmap,
    Color dividerColor, {
    required Color colorMuted,
    required Color colorWhite,
  }) {
    final timelineData = roadmap;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: timelineData.asMap().entries.map((entry) {
        int idx = entry.key;

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
                      color: [
                        const Color(0xFF0F2447),
                        const Color(0xFF1B1938),
                        const Color(0xFF08243A),
                        const Color(0xFF0C251F),
                      ][idx % 4],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: [
                          const Color(0xFF3B82F6),
                          const Color(0xFF8B5CF6),
                          const Color(0xFF00A2E8),
                          const Color(0xFF10B981),
                        ][idx % 4].withOpacity(0.4),
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
                        color: [
                          const Color(0xFF3B82F6),
                          const Color(0xFF8B5CF6),
                          const Color(0xFF00A2E8),
                          const Color(0xFF10B981),
                        ][idx % 4],
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
                'Year ${idx + 1}',
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timelineData[idx],
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
}
