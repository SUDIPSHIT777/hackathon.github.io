import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  static const Color bgColor = Color(0xff051429);
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color textMuted = Color(0xFF6B7A90);

  @override
  void initState() {
    super.initState();
    // Continuous spinning & pulsing controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1. Glowing Scanner / Radar Visual
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer ambient pulse
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Container(
                                width: 160 * _pulseAnimation.value,
                                height: 160 * _pulseAnimation.value,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: accentCyan.withOpacity(0.03 * (1 - _pulseAnimation.value + 0.6)),
                                ),
                              );
                            },
                          ),
                          // Middle static glow ring
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: accentCyan.withOpacity(0.15),
                                width: 2,
                              ),
                            ),
                          ),
                          // Rotating radar sweep
                          RotationTransition(
                            turns: _animationController,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: SweepGradient(
                                  colors: [
                                    accentCyan.withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.2, 1.0],
                                ),
                              ),
                            ),
                          ),
                          // Inner static core circle with floating Document Icon
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF071324),
                            ),
                            child: const Icon(
                              Icons.document_scanner_outlined,
                              color: accentCyan,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // 2. Animated Progress Headers
                      Text(
                        "Analyzing Resume...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Pulsing helper text
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _pulseAnimation.value,
                            child: child,
                          );
                        },
                        child: const Text(
                          "Extracting skills and mapping tailored career pathways just for you.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textMuted,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // 3. Clean Modern Linear Tracker Base
                      SizedBox(
                        width: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                            backgroundColor: Color(0xFF132D4A),
                            valueColor: AlwaysStoppedAnimation<Color>(accentCyan),
                            minHeight: 4,
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
}