import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hackathon/screen/explore_careers/path_chooser/path_chooser_screen.dart';

class DegreeChooserScreen extends StatefulWidget {
  const DegreeChooserScreen({super.key});

  @override
  State<DegreeChooserScreen> createState() => _DegreeChooserScreenState();
}

class _DegreeChooserScreenState extends State<DegreeChooserScreen> {
  // Managing index variable tracking user selection
  int _selectedDegreeIdx = 0;

  // Mock degree data extracted exactly from Step 2 of your reference image
  final List<Map<String, dynamic>> _degrees = [
    {
      'title': 'B.Tech Computer Science',
      'duration': 'Duration: 4 Years',
      'salary': '₹ 8 - 18 LPA',
      'icon': Icons.code_rounded,
      'iconColor': const Color(0xFF3B82F6),
      'iconBg': const Color(0xFF0F2447),
    },
    {
      'title': 'B.Sc',
      'duration': 'Duration: 3 Years',
      'salary': '₹ 3 - 6 LPA',
      'icon': Icons.science_outlined,
      'iconColor': const Color(0xFF00D2A0),
      'iconBg': const Color(0xFF092524),
    },
    {
      'title': 'BCA',
      'duration': 'Duration: 3 Years',
      'salary': '₹ 4 - 8 LPA',
      'icon': Icons.terminal_rounded,
      'iconColor': const Color(0xFFF59E0B),
      'iconBg': const Color(0xFF2A2011),
    },
    {
      'title': 'MBBS',
      'duration': 'Duration: 5.5 Years',
      'salary': '₹ 10 - 25 LPA',
      'icon': Icons.health_and_safety_outlined,
      'iconColor': const Color(0xFFEF4444),
      'iconBg': const Color(0xFF2C141A),
    },
    {
      'title': 'B.Pharm',
      'duration': 'Duration: 4 Years',
      'salary': '₹ 4 - 7 LPA',
      'icon': Icons.medication_liquid_outlined,
      'iconColor': const Color(0xFF8B5CF6),
      'iconBg': const Color(0xFF1B1938),
    },
    {
      'title': 'Biotechnology',
      'duration': 'Duration: 4 Years',
      'salary': '₹ 4 - 8 LPA',
      'icon': Icons.biotech_outlined,
      'iconColor': const Color(0xFF00A2E8),
      'iconBg': const Color(0xFF08243A),
    },
    {
      'title': 'Data Science',
      'duration': 'Duration: 3-4 Years',
      'salary': '₹ 6 - 14 LPA',
      'icon': Icons.hub_outlined,
      'iconColor': const Color(0xFFEC4899),
      'iconBg': const Color(0xFF2B1428),
    },
    {
      'title': 'Environmental Science',
      'duration': 'Duration: 3 Years',
      'salary': '₹ 3 - 6 LPA',
      'icon': Icons.eco_outlined,
      'iconColor': const Color(0xFF10B981),
      'iconBg': const Color(0xFF0C251F),
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Shared space-dark theme color canvas configurations
    const Color colorBg = Color(0xff051429);
    const Color colorCardBg = Color.fromARGB(255, 19, 38, 60);
    const Color colorSearchBg = Color(0xFF0D1829);
    const Color colorTextWhite = Colors.white;
    const Color colorTextMuted = Color(0xFF6B7A90);
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
                            // --- TOP PROGRESS STEPPER (STEP 2 ACTIVE) ---
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Text(
                            //       'Step 2 of 4',
                            //       style: TextStyle(
                            //         color: colorTextMuted,
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //     _buildStepperTracker(colorBorderDefault),
                            //   ],
                            // ),
                            // const SizedBox(height: 24),

                            // --- SECTION HEADERS ---
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'sans-serif',
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Choose Your ',
                                    style: TextStyle(color: colorTextWhite),
                                  ),
                                  TextSpan(
                                    text: 'Course / Degree',
                                    style: TextStyle(color: Color(0xFF3B82F6)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'Select the course you want to pursue in ',
                                  style: TextStyle(
                                    color: colorTextMuted,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Science stream.',
                                  style: TextStyle(
                                    color: Color(0xFF3B82F6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // --- SEARCH FILTER BAR WITH INTEGRATED TUNING ICON ---
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: colorSearchBg,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: colorBorderDefault,
                                        width: 1,
                                      ),
                                    ),
                                    child: const TextField(
                                      style: TextStyle(
                                        color: colorTextWhite,
                                        fontSize: 14,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Search course',
                                        hintStyle: TextStyle(
                                          color: Color(0xFF435368),
                                          fontSize: 14,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Color(0xFF435368),
                                          size: 20,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Tuning option icon block
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: colorSearchBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: colorBorderDefault,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.tune_rounded,
                                    color: Color(0xFF3B82F6),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // --- LIST VIEW LAYOUT FOR DEGREES ---
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _degrees.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final degree = _degrees[index];
                                final bool isSelected =
                                    _selectedDegreeIdx == index;
                                final Color currentAccent = degree['iconColor'];

                                return GestureDetector(
                                  onTap: () => setState(
                                    () => _selectedDegreeIdx = index,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: colorCardBg,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: isSelected
                                            ? currentAccent
                                            : colorBorderDefault,
                                        width: isSelected ? 1.5 : 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        // Staged custom tinted icon box matching stream specifications
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: degree['iconBg'],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Icon(
                                            degree['icon'],
                                            color: currentAccent,
                                            size: 22,
                                          ),
                                        ),
                                        const SizedBox(width: 16),

                                        // Core Information metadata blocks
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                degree['title'],
                                                style: const TextStyle(
                                                  color: colorTextWhite,
                                                  fontSize: 14.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    degree['duration'],
                                                    style: const TextStyle(
                                                      color: colorTextMuted,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 3,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xFF112239,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      degree['salary'],
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? currentAccent
                                                            : colorTextWhite,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Dynamic selection ring components
                                        Icon(
                                          isSelected
                                              ? Icons.check_circle
                                              : Icons.radio_button_off_outlined,
                                          color: isSelected
                                              ? currentAccent
                                              : const Color(0xFF33475E),
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),

                    // --- STICKY FOOTER INTERACTION NEXT ACTION ITEM ---
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 16.0,
                      ),
                      child: Container(
                        height: 52,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF007BFF), Color(0xFF0052D4)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
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
                            Get.to(
                              () => PathChooserScreen(),
                              transition: Transition.rightToLeft,
                            );
                            // Link routing transitions towards Step 3 panel components
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: colorTextWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: colorTextWhite,
                                size: 18,
                              ),
                            ],
                          ),
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

  // Linear custom tracker element mirroring the 4-step circle architecture sequence
  Widget _buildStepperTracker(Color baseBorder) {
    return Row(
      children: List.generate(4, (index) {
        final bool isPassed = index < 1;
        final bool isCurrent = index == 1;

        return Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPassed || isCurrent
                    ? const Color(0xFF00D2A0)
                    : Colors.transparent,
                border: Border.all(
                  color: isPassed || isCurrent
                      ? const Color(0xFF00D2A0)
                      : baseBorder,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: isPassed
                    ? const Icon(Icons.check, color: Colors.white, size: 10)
                    : Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isCurrent
                              ? Colors.white
                              : const Color(0xFF4E6178),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            if (index != 3)
              Container(
                width: 14,
                height: 1.5,
                color: index < 1 ? const Color(0xFF00D2A0) : baseBorder,
              ),
          ],
        );
      }),
    );
  }
}
