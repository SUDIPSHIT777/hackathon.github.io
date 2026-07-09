import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hackathon/screen/explore_careers/degree_chooser/controller/DegreeChooserController.dart';
import 'package:hackathon/screen/explore_careers/path_chooser/path_chooser_screen.dart';
import 'package:provider/provider.dart';

class DegreeChooserScreen extends StatefulWidget {
  final String stream;

  const DegreeChooserScreen({super.key, required this.stream});

  @override
  State<DegreeChooserScreen> createState() => _DegreeChooserScreenState();
}

class _DegreeChooserScreenState extends State<DegreeChooserScreen> {
  // Managing index variable tracking user selection
  int _selectedDegreeIdx = 0;

   @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DegreeChooserController>().loadDegrees(widget.stream);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Shared space-dark theme color canvas configurations
    const Color colorBg = Color(0xff051429);
    const Color colorCardBg = Color.fromARGB(255, 19, 38, 60);
    const Color colorTextWhite = Colors.white;
    const Color colorTextMuted = Color(0xFF6B7A90);
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
                              children: [
                                const Text(
                                  'Select the course you want to pursue in ',
                                  style: TextStyle(
                                    color: colorTextMuted,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${widget.stream} stream.',
                                  style: const TextStyle(
                                    color: Color(0xFF3B82F6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                              const SizedBox(height: 24),
                            Consumer<DegreeChooserController>(
                              builder: (context, controller, child) {
                                if (controller.isLoading) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(40),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }

                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.degrees.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final degree = controller.degrees[index];

                                    final Color currentAccent =
                                        degreeColors[index %
                                            degreeColors.length];

                                    final Color currentBg =
                                        degreeBgColors[index %
                                            degreeBgColors.length];

                                    final bool isSelected =
                                        _selectedDegreeIdx == index;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedDegreeIdx = index;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: colorCardBg,
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color: isSelected
                                                ? currentAccent
                                                : colorBorderDefault,
                                            width: isSelected ? 1.5 : 1,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: currentBg,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.school_outlined,
                                                color: currentAccent,
                                                size: 22,
                                              ),
                                            ),

                                            const SizedBox(width: 16),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    degree.title,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),

                                                  const SizedBox(height: 4),

                                                  Row(
                                                    children: [
                                                      Text(
                                                        degree.duration,
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
                                                          degree.salary,
                                                          style: TextStyle(
                                                            color: isSelected
                                                                ? currentAccent
                                                                : Colors.white,
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

                                            Icon(
                                              isSelected
                                                  ? Icons.check_circle
                                                  : Icons
                                                        .radio_button_off_outlined,
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
                                );
                              },
                            ),
                            // --- LIST VIEW LAYOUT FOR DEGREES ---
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
                            final degreeController = context
                                .read<DegreeChooserController>();

                            if (degreeController.degrees.isEmpty) return;

                            final selectedDegree =
                                degreeController.degrees[_selectedDegreeIdx];

                            Get.to(
                              () => PathChooserScreen(
                                stream: widget.stream,
                                degree: selectedDegree.title,
                              ),
                              transition: Transition.rightToLeft,
                            );
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

  final List<Color> degreeColors = [
    const Color(0xFF3B82F6),
    const Color(0xFF00D2A0),
    const Color(0xFFF59E0B),
    const Color(0xFFEF4444),
    const Color(0xFF8B5CF6),
    const Color(0xFF00A2E8),
    const Color(0xFFEC4899),
    const Color(0xFF10B981),
  ];
  final List<Color> degreeBgColors = [
    const Color(0xFF0F2447),
    const Color(0xFF092524),
    const Color(0xFF2A2011),
    const Color(0xFF2C141A),
    const Color(0xFF1B1938),
    const Color(0xFF08243A),
    const Color(0xFF2B1428),
    const Color(0xFF0C251F),
  ];
  // Linear custom tracker element mirroring the 4-step circle architecture sequence
}
