import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/model/aiRespons_model.dart';
import 'package:hackathon/screen/bottomNav/bottom_nav.dart';
import 'package:hackathon/screen/resume_result/controller/resume_result_controller.dart';
import 'package:provider/provider.dart';

class ResumeResultScreen extends StatefulWidget {
  final String page;
  const ResumeResultScreen({super.key, required this.page});

  @override
  State<ResumeResultScreen> createState() =>
      _ResumeAnalysisResultsScreenState();
}

class _ResumeAnalysisResultsScreenState extends State<ResumeResultScreen>
    with SingleTickerProviderStateMixin {

  // Animated score value
  late AnimationController _scoreAnimController;
  late Animation<double> _scoreAnim;

  // ── Color palette ──────────────────────────────────────────────────────────
  static const Color colorBg = Color(0xff051429);
  static const Color colorCardBg = Color.fromARGB(255, 19, 38, 60);
  static const Color colorTextWhite = Colors.white;
  static const Color colorTextMuted = Color(0xFF7D8E9F);
  static const Color colorMint = Color(0xFF00D2A0);
  static const Color colorRedAccent = Color(0xFFEF4444);
  static const Color colorBlueAccent = Color(0xFF3B82F6);
  // static const Color colorTabBg = Color(0xFF0D1724);

  @override
  void initState() {
    super.initState();
    _scoreAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scoreAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _scoreAnimController, curve: Curves.easeOut),
    );
    // Kick off animation after first frame so controller data is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scoreAnimController.forward();
    });
  }

  @override
  void dispose() {
    _scoreAnimController.dispose();
    super.dispose();
  }

  // ── Score → accent colour (mirrors Screen 2 logic) ────────────────────────
  Color _scoreColor(int score) {
    if (score < 50) return colorRedAccent;
    if (score < 80) return Colors.orange;
    return colorMint;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ResumeResultController>(
      builder: (context, controller, _) {
        final resume = controller.respons;
        final int score = resume.score;
        final double scorePercent = (score / 100).clamp(0.0, 1.0);
        final Color accentColor = _scoreColor(score);

        return Scaffold(
          backgroundColor: colorBg,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: colorTextWhite),
              onPressed: () =>
                  Get.offAll(() => BottomNav(), transition: Transition.fade),
            ),
            title: Text(
              "RESUME RESULT",
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
                final bool isWide = constraints.maxWidth > 650;
                final double hPad = isWide ? 48.0 : 16.0;

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      children: [
                        // // ── Tab bar ──────────────────────────────────────────
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: hPad,
                        //     vertical: 8,
                        //   ),
                        //   child: Container(
                        //     padding: const EdgeInsets.all(4),
                        //     decoration: BoxDecoration(
                        //       color: colorTabBg,
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     child: SingleChildScrollView(
                        //       scrollDirection: Axis.horizontal,
                        //       child: Row(
                        //         children: [
                        //           _buildSubTab(0, 'Overview'),
                        //           _buildSubTab(1, 'Detailed Result'),
                        //           _buildSubTab(2, 'Step-by-Step'),
                        //           _buildSubTab(3, 'Summary'),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // ── Scrollable body ──────────────────────────────────
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: hPad,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 1. Score card (now dynamic + animated)
                                _buildOverallScoreCard(
                                  resume.name,
                                  score,
                                  scorePercent,
                                  accentColor,
                                  resume.summary,
                                ),
                                const SizedBox(height: 24),

                                // 2. Missing Skills (from Screen 2)
                                _buildSectionHeader(
                                  'Missing Skills',
                                  Colors.amber,
                                ),
                                const SizedBox(height: 12),
                                _buildMissingSkillsCard(resume.missingSkills),
                                const SizedBox(height: 24),

                                // 3. Critical Gaps (now dynamic)
                                _buildSectionHeader(
                                  'Critical Gaps',
                                  colorRedAccent,
                                ),
                                const SizedBox(height: 12),
                                _buildDynamicCardList(
                                  resume.criticalGaps,
                                  Icons.info,
                                  colorRedAccent,
                                ),
                                const SizedBox(height: 24),

                                // 4. Key Strengths (now dynamic)
                                _buildSectionHeader(
                                  'Key Strengths',
                                  colorBlueAccent,
                                ),
                                const SizedBox(height: 12),
                                _buildDynamicCardList(
                                  resume.keyStrengths,
                                  Icons.done_all_sharp,
                                  colorBlueAccent,
                                ),
                                const SizedBox(height: 24),

                                // 5. Step-by-Step Optimization (now dynamic)
                                _buildSectionHeader(
                                  'Step-by-Step Optimization',
                                  colorMint,
                                ),
                                const SizedBox(height: 12),
                                _buildOptimizationStepsList(
                                  resume.optimizationSteps,
                                ),
                                const SizedBox(height: 24),

                                // 6. AI Recommendation & Market Match (now dynamic)
                                isWide
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: _buildAiRecommendationCard(
                                              resume.aiRecommendation,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: _buildMarketMatchCard(
                                              resume.marketMatch,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          _buildAiRecommendationCard(
                                            resume.aiRecommendation,
                                          ),
                                          const SizedBox(height: 12),
                                          _buildMarketMatchCard(
                                            resume.marketMatch,
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 20),

                                // 7. Motivational footer text (from Screen 2)
                                Center(
                                  child: Text(
                                    'Every improvement here brings you closer to your dream job.'
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colorTextMuted,
                                      fontSize: 11,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
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
      },
    );
  }

  // // ── Tab segment ─────────────────────────────────────────────────────────────
  // Widget _buildSubTab(int index, String label) {
  //   final bool isSelected = _activeTabIdx == index;
  //   return GestureDetector(
  //     onTap: () => setState(() => _activeTabIdx = index),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //       decoration: BoxDecoration(
  //         color: isSelected ? colorTabActiveBg : Colors.transparent,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Text(
  //         label,
  //         style: TextStyle(
  //           color: isSelected ? colorTextWhite : colorTextMuted,
  //           fontSize: 13,
  //           fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // ── Section header ───────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title, Color barColor) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: barColor,
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

  // ── Overall score card (animated, dynamic, shows candidate name) ─────────────
  Widget _buildOverallScoreCard(
    String name,
    int score,
    double scorePercent,
    Color accentColor,
    String summary,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Candidate name
          if (name.isNotEmpty) ...[
            Text(
              name,
              style: const TextStyle(
                color: colorTextWhite,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overall Score',
                      style: TextStyle(color: colorTextMuted, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$score/100',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      summary.isNotEmpty
                          ? summary
                          : 'Great job! Your resume looks strong.',
                      style: const TextStyle(
                        color: colorTextMuted,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Animated circular indicator
              AnimatedBuilder(
                animation: _scoreAnim,
                builder: (_, __) {
                  final double animatedValue = scorePercent * _scoreAnim.value;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 84,
                        height: 84,
                        child: CircularProgressIndicator(
                          value: animatedValue,
                          strokeWidth: 7,
                          backgroundColor: const Color(0xFF112237),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            accentColor,
                          ),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Text(
                        '${(score * _scoreAnim.value).round()}',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Missing Skills card (new from Screen 2) ──────────────────────────────────
  Widget _buildMissingSkillsCard(List missingSkills) {
    return Container(
      width: double.infinity,
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
              const Icon(
                CupertinoIcons.sparkles,
                color: Colors.amber,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'MISSING SKILLS',
                style: TextStyle(
                  color: colorTextMuted,
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (missingSkills.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: missingSkills
                  .map<Widget>((skill) => _buildSkillChip(skill.toString()))
                  .toList(),
            ),
          ] else ...[
            const SizedBox(height: 10),
            const Text(
              'No missing skills detected.',
              style: TextStyle(color: colorTextMuted, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.3), width: 1),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: Colors.amber,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ── Dynamic card list for Gaps / Strengths (driven by CardModel list) ────────
  Widget _buildDynamicCardList(
    List<CardModel> items,
    IconData icon,
    Color iconColor,
  ) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorCardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'No items found.',
          style: TextStyle(color: colorTextMuted, fontSize: 13),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final int idx = entry.key;
          final CardModel item = entry.value;
          return Column(
            children: [
              _buildRowItem(icon, iconColor, item.title, item.description),
              if (idx != items.length - 1)
                const Divider(color: Color(0xFF142438), height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── Optimization steps list (now driven by dynamic data) ─────────────────────
  Widget _buildOptimizationStepsList(List steps) {
    if (steps.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorCardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'No optimization steps available.',
          style: TextStyle(color: colorTextMuted, fontSize: 13),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: colorCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: steps.asMap().entries.map((entry) {
          final int idx = entry.key;
          final String text = entry.value.toString();
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
                    Icons.keyboard_double_arrow_right_rounded,
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

  // ── AI Recommendation card (now dynamic) ─────────────────────────────────────
  Widget _buildAiRecommendationCard(String recommendation) {
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
              const Expanded(
                child: Text(
                  'AI Recommendation',
                  style: TextStyle(
                    color: colorTextWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            recommendation.isNotEmpty
                ? recommendation
                : 'No recommendation available.',
            style: const TextStyle(
              color: colorTextMuted,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ── Market Match card (now dynamic) ──────────────────────────────────────────
  Widget _buildMarketMatchCard(String marketMatch) {
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
          Text(
            marketMatch.isNotEmpty
                ? marketMatch
                : 'No market match data available.',
            style: const TextStyle(
              color: colorTextMuted,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ── Shared row item (gaps & strengths) ────────────────────────────────────────
  Widget _buildRowItem(
    IconData icon,
    Color iconColor,
    String title,
    String subTitle,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
