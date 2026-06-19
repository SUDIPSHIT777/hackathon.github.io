import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/screen/bottomNav/bottom_nav.dart';
import 'package:hackathon/screen/login/login.dart';
import 'package:hackathon/screen/signup/authwrapper.dart';

class CareerCompassPage extends StatefulWidget {
  const CareerCompassPage({super.key});

  @override
  State<CareerCompassPage> createState() => _CareerCompassPageState();
}

class _CareerCompassPageState extends State<CareerCompassPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthGate()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF01121A),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF041E26), Color(0xFF02161E), Color(0xFF010D14)],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              const _BackgroundGlowsAndOrbits(),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 24,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              const _TitleSection(),
                              const SizedBox(height: 24),
                              const _TaglineSection(),
                              const Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    child: _CompassIllustration(),
                                  ),
                                ),
                              ),
                              LinearProgressIndicator(
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 9, 36, 57),
                              ),
                              SizedBox(height: 10),
                              _PrimaryButton(
                                text: 'App is loading...',
                                onTap: () {},
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'CAREER',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            letterSpacing: 3.5,
            height: 1.1,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              letterSpacing: 3.5,
              height: 1.1,
            ),
            children: [
              TextSpan(
                text: 'C',
                style: TextStyle(color: Color(0xFF00E6D4)),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: _MiniCompass(),
                ),
              ),
              TextSpan(
                text: 'MPASS',
                style: TextStyle(color: Color(0xFF00E6D4)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Campus Career Navigator',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFC0DFE5),
            fontSize: 17,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _TaglineSection extends StatelessWidget {
  const _TaglineSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Navigate. Grow. Succeed.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Your pathway to a\nsuccessful career\nstarts here.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF8AA6AE),
            fontSize: 17,
            fontWeight: FontWeight.w400,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PrimaryButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF008AA1), Color(0xFF00DEC9), Color(0xFF7BFFDF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E6D4).withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackgroundGlowsAndOrbits extends StatelessWidget {
  const _BackgroundGlowsAndOrbits();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          right: -100,
          child: _glowCircle(400, const Color(0x0C00E6D4)),
        ),
        Positioned(
          bottom: -100,
          left: -100,
          child: _glowCircle(350, const Color(0x0A00E6D4)),
        ),
        Positioned.fill(
          child: CustomPaint(painter: _BackgroundDetailsPainter()),
        ),
      ],
    );
  }

  Widget _glowCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 120, spreadRadius: 50)],
      ),
    );
  }
}

class _CompassIllustration extends StatelessWidget {
  const _CompassIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280, maxHeight: 280),
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(painter: _MainCompassPainter()),
      ),
    );
  }
}

class _MiniCompass extends StatelessWidget {
  const _MiniCompass();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CustomPaint(painter: _MiniCompassPainter()),
    );
  }
}

class _MainCompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;

    final radialGlow = Paint()
      ..color = const Color(0xFF00E6D4).withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(center, radius * 0.8, radialGlow);

    final outerBrightRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..color = const Color(0xFF00E6D4).withOpacity(0.85);

    final thinGuideRing1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = const Color(0xFF00E6D4).withOpacity(0.2);

    canvas.drawCircle(center, radius * 0.80, outerBrightRing);
    canvas.drawCircle(center, radius * 0.86, thinGuideRing1);
    canvas.drawCircle(center, radius * 0.72, thinGuideRing1);
    canvas.drawCircle(center, radius * 0.52, thinGuideRing1);

    final axisPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0xFF00E6D4).withOpacity(0.35);

    final minAxisDist = radius * 0.15;
    final maxAxisDist = radius * 0.80;

    canvas.drawLine(
      Offset(center.dx, center.dy - maxAxisDist),
      Offset(center.dx, center.dy - minAxisDist),
      axisPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy + minAxisDist),
      Offset(center.dx, center.dy + maxAxisDist),
      axisPaint,
    );
    canvas.drawLine(
      Offset(center.dx - maxAxisDist, center.dy),
      Offset(center.dx - minAxisDist, center.dy),
      axisPaint,
    );
    canvas.drawLine(
      Offset(center.dx + minAxisDist, center.dy),
      Offset(center.dx + maxAxisDist, center.dy),
      axisPaint,
    );

    final diagonalPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..color = const Color(0xFF00E6D4).withOpacity(0.15);

    for (var angle in [45, 135, 225, 315]) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle * 3.1415926535 / 180);
      canvas.drawLine(
        Offset(0, -maxAxisDist * 0.9),
        Offset(0, -minAxisDist),
        diagonalPaint,
      );
      canvas.restore();
    }

    final mainLength = radius * 0.68;
    final mainWidth = radius * 0.13;
    _drawSharpNeedle(
      canvas,
      center,
      mainLength,
      mainWidth,
      0,
      const Color(0xFF00E6D4),
    );
    _drawSharpNeedle(
      canvas,
      center,
      mainLength,
      mainWidth,
      90,
      const Color(0xFF00DEC9),
    );
    _drawSharpNeedle(
      canvas,
      center,
      mainLength,
      mainWidth,
      180,
      const Color(0xFF00BFAF),
    );
    _drawSharpNeedle(
      canvas,
      center,
      mainLength,
      mainWidth,
      270,
      const Color(0xFF00DEC9),
    );

    final subLength = radius * 0.40;
    final subWidth = radius * 0.08;
    _drawSharpNeedle(
      canvas,
      center,
      subLength,
      subWidth,
      45,
      const Color(0xFF00A194),
    );
    _drawSharpNeedle(
      canvas,
      center,
      subLength,
      subWidth,
      135,
      const Color(0xFF00A194),
    );
    _drawSharpNeedle(
      canvas,
      center,
      subLength,
      subWidth,
      225,
      const Color(0xFF00A194),
    );
    _drawSharpNeedle(
      canvas,
      center,
      subLength,
      subWidth,
      315,
      const Color(0xFF00A194),
    );

    final centerDialHole = Paint()..color = const Color(0xFF01141C);
    canvas.drawCircle(center, radius * 0.08, centerDialHole);

    final centerGlassGlow = Paint()
      ..color = const Color(0xFF8BFFE3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawCircle(center, radius * 0.045, centerGlassGlow);
    canvas.drawCircle(center, radius * 0.02, Paint()..color = Colors.white);

    _drawArrowCap(canvas, Offset(center.dx, center.dy - radius * 0.94));
    _drawCardinalText(
      canvas,
      'A',
      Offset(center.dx, center.dy - radius * 0.66),
    );
    _drawCardinalText(
      canvas,
      'G',
      Offset(center.dx + radius * 0.68, center.dy),
    );
    _drawCardinalText(
      canvas,
      'O',
      Offset(center.dx, center.dy + radius * 0.68),
    );
    _drawCardinalText(
      canvas,
      'S',
      Offset(center.dx - radius * 0.68, center.dy),
    );
  }

  void _drawSharpNeedle(
    Canvas canvas,
    Offset center,
    double length,
    double baseWidth,
    double angleDegree,
    Color baseColor,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angleDegree * 3.1415926535 / 180);

    final pathLeft = Path()
      ..moveTo(0, 0)
      ..lineTo(-baseWidth, 0)
      ..lineTo(0, -length)
      ..close();

    final pathRight = Path()
      ..moveTo(0, 0)
      ..lineTo(baseWidth, 0)
      ..lineTo(0, -length)
      ..close();

    final leftPaint = Paint()..color = baseColor;
    final rightPaint = Paint()..color = baseColor.withOpacity(0.45);

    canvas.drawPath(pathLeft, leftPaint);
    canvas.drawPath(pathRight, rightPaint);
    canvas.restore();
  }

  void _drawCardinalText(Canvas canvas, String text, Offset offset) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF00E6D4),
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(
        offset.dx - textPainter.width / 2,
        offset.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawArrowCap(Canvas canvas, Offset offset) {
    final path = Path()
      ..moveTo(offset.dx, offset.dy - 5)
      ..lineTo(offset.dx - 6, offset.dy + 3)
      ..lineTo(offset.dx, offset.dy + 0)
      ..lineTo(offset.dx + 6, offset.dy + 3)
      ..close();

    final paint = Paint()
      ..color = const Color(0xFF00E6D4)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniCompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final outerRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..color = const Color(0xFF00E6D4);
    canvas.drawCircle(center, radius - 2, outerRing);

    final alignmentLines = Paint()
      ..color = const Color(0xFF00E6D4).withOpacity(0.35)
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(center.dx, 4),
      Offset(center.dx, size.height - 4),
      alignmentLines,
    );
    canvas.drawLine(
      Offset(4, center.dy),
      Offset(size.width - 4, center.dy),
      alignmentLines,
    );

    final solidNeedlePaint = Paint()..color = const Color(0xFF00E6D4);
    final shadedNeedlePaint = Paint()
      ..color = const Color(0xFF00E6D4).withOpacity(0.4);

    for (var i = 0; i < 4; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(i * 90 * 3.1415926535 / 180);

      final pLeft = Path()
        ..moveTo(0, 0)
        ..lineTo(-3, 0)
        ..lineTo(0, -radius + 4)
        ..close();
      final pRight = Path()
        ..moveTo(0, 0)
        ..lineTo(3, 0)
        ..lineTo(0, -radius + 4)
        ..close();

      canvas.drawPath(pLeft, solidNeedlePaint);
      canvas.drawPath(pRight, shadedNeedlePaint);
      canvas.restore();
    }
    canvas.drawCircle(center, 1.8, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BackgroundDetailsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fineRingPaint = Paint()
      ..color = const Color(0xFF00E6D4).withOpacity(0.035)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final centerOfOrbits = Offset(size.width * 0.5, size.height * 0.56);

    canvas.drawCircle(centerOfOrbits, size.width * 0.54, fineRingPaint);
    canvas.drawCircle(centerOfOrbits, size.width * 0.72, fineRingPaint);

    final lightStarPaint = Paint()
      ..color = const Color(0xFF00E6D4).withOpacity(0.4);
    canvas.drawCircle(
      Offset(size.width * 0.14, size.height * 0.48),
      1.5,
      lightStarPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.40),
      2.2,
      lightStarPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.65),
      1.2,
      lightStarPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.20, size.height * 0.70),
      1.8,
      lightStarPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const BottomNav();
        }

        return const LoginScreen();
      },
    );
  }
}
