import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hackathon/screen/explore_careers/degree_chooser/degree_chooser_screen.dart';

class ChooseStreamScreen extends StatefulWidget {
  const ChooseStreamScreen({super.key});

  @override
  State<ChooseStreamScreen> createState() => _ChooseStreamScreenState();
}

class _ChooseStreamScreenState extends State<ChooseStreamScreen> {
  // Tracks the currently selected stream card index
  int _selectedCardIndex = 0;

  // Mock stream list data extracted directly from Step 1 of your reference image
  final List<Map<String, dynamic>> _streams = [
    {
      'title': 'Science',
      'subtitle': 'Explore the world of experiments & innovation',
      'icon': Icons.science_outlined,
      'color': const Color(0xFF3B82F6), // Accent Blue
    },
    {
      'title': 'Commerce',
      'subtitle': 'Build skills in finance, trade & business',
      'icon': Icons.trending_up_rounded,
      'color': const Color(0xFF8B5CF6), // Purple accent hint
    },
    {
      'title': 'Arts & Humanities',
      'subtitle': 'Unleash creativity & understand human society',
      'icon': Icons.palette_outlined,
      'color': const Color(0xFFEF4444), // Crimson
    },
    {
      'title': 'Computer Science & IT',
      'subtitle': 'Step into technology and digital future',
      'icon': Icons.computer_outlined,
      'color': const Color(0xFF00D2A0), // Mint Green
    },
    {
      'title': 'Engineering',
      'subtitle': 'Design, build & shape the future',
      'icon': Icons.settings_input_component_outlined,
      'color': const Color(0xFF3B82F6),
    },
    {
      'title': 'Business Management',
      'subtitle': 'Lead teams & drive business growth',
      'icon': Icons.corporate_fare_outlined,
      'color': const Color(0xFF8B5CF6),
    },
    {
      'title': 'Medical',
      'subtitle': 'Serve lives & build a rewarding career',
      'icon': Icons.favorite_border_rounded,
      'color': const Color(0xFFEF4444),
    },
    {
      'title': 'Other / Not Sure',
      'subtitle': 'Explore options we recommend for you',
      'icon': Icons.help_outline_rounded,
      'color': const Color(0xFF7E8F9F),
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Exact theme color hex codes sampled from the image
    const Color colorBg = Color(0xff051429);
    const Color colorCardBg = Color.fromARGB(255, 19, 38, 60);
    // const Color colorSearchBg = Color(0xFF0D1829);
    const Color colorTextWhite = Colors.white;
    const Color colorTextMuted = Color(0xFF6B7A90);
    const Color colorActiveStep = Color(0xFF3B82F6);

    final Color colorBorderDefault = const Color(0xFF13233A);

    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: colorTextWhite),
        //   onPressed: () {},
        // ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Adaptive horizontal grid changes based on the width parameters
            final bool isWideScreen = constraints.maxWidth > 650;
            final double horizontalPadding = isWideScreen ? 48.0 : 20.0;
            final int crossAxisGridCount = isWideScreen ? 3 : 2;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 750),
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
                            // --- TOP RESPONSIVE STEPPER BAR ---
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Text(
                            //       'Step 1 of 4',
                            //       style: TextStyle(
                            //         color: colorTextMuted,
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //     _buildStepperTracker(
                            //       colorActiveStep,
                            //       colorBorderDefault,
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 24),

                            // --- SECTION TEXT HEADERS ---
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
                                    text: 'Stream',
                                    style: TextStyle(color: Color(0xFF3B82F6)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Select your academic stream to discover the best career opportunities.',
                              style: TextStyle(
                                color: colorTextMuted,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // // --- SEARCH FILTER INPUT FIELD ---
                            // Container(
                            //   height: 52,
                            //   decoration: BoxDecoration(
                            //     color: colorSearchBg,
                            //     borderRadius: BorderRadius.circular(12),
                            //     border: Border.all(
                            //       color: colorBorderDefault,
                            //       width: 1,
                            //     ),
                            //   ),
                            //   child: const TextField(
                            //     style: TextStyle(
                            //       color: colorTextWhite,
                            //       fontSize: 14,
                            //     ),
                            //     decoration: InputDecoration(
                            //       hintText: 'Search stream',
                            //       hintStyle: TextStyle(
                            //         color: Color(0xFF435368),
                            //         fontSize: 14,
                            //       ),
                            //       prefixIcon: Icon(
                            //         Icons.search,
                            //         color: Color(0xFF435368),
                            //         size: 20,
                            //       ),
                            //       border: InputBorder.none,
                            //       contentPadding: EdgeInsets.symmetric(
                            //         vertical: 15,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 28),

                            // --- DYNAMIC SELECTION CARDS GRID ---
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _streams.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisGridCount,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: isWideScreen ? 1.5 : 1.15,
                                  ),
                              itemBuilder: (context, index) {
                                final stream = _streams[index];
                                final bool isSelected =
                                    _selectedCardIndex == index;
                                final Color accentColor = stream['color'];

                                return GestureDetector(
                                  onTap: () => setState(
                                    () => _selectedCardIndex = index,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: colorCardBg,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: isSelected
                                            ? accentColor
                                            : colorBorderDefault,
                                        width: isSelected ? 1.5 : 1.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              stream['icon'],
                                              color: accentColor,
                                              size: 26,
                                            ),
                                            if (isSelected)
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: accentColor
                                                      .withOpacity(0.15),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: accentColor,
                                                  size: 18,
                                                ),
                                              ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              stream['title'],
                                              style: const TextStyle(
                                                color: colorTextWhite,
                                                fontSize: 14.5,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              stream['subtitle'],
                                              style: const TextStyle(
                                                color: colorTextMuted,
                                                fontSize: 11,
                                                height: 1.3,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
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

                    // --- BOTTOM GLOWING STICKY NEXT BUTTON ---
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
                            // Forward navigation stack operations
                            Get.to(
                              () => DegreeChooserScreen(),
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

  // Helper code to build the inline custom progress stepper circles
  Widget _buildStepperTracker(Color activeColor, Color baseBorder) {
    return Row(
      children: List.generate(4, (index) {
        final bool isCurrent = index == 0;
        return Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCurrent ? activeColor : Colors.transparent,
                border: Border.all(
                  color: isCurrent ? activeColor : baseBorder,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: isCurrent ? Colors.white : const Color(0xFF4E6178),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (index != 3)
              Container(width: 14, height: 1.5, color: baseBorder),
          ],
        );
      }),
    );
  }
}
