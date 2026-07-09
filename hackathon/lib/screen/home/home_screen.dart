import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/chatboat/ui/chatboatui.dart';
import 'package:hackathon/screen/internship/ui/internship.dart';
import 'package:hackathon/screen/explore_careers/stream_chooser/exploer_careers_screen.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/model/taskmodel.dart';
import 'package:hackathon/screen/tasks/ui/taskpageui.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Using LayoutBuilder to fetch parent constraints for responsiveness
    return Scaffold(
      backgroundColor: const Color(0xff051429),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: const Color(0xff051429),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            width: 36,
            height: 36,
            child: CustomPaint(painter: _AppBarCompassPainter()),
          ),
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontSize: 18,
            ),
            children: [
              const TextSpan(text: 'CAREER '),
              const TextSpan(
                text: 'C',
                style: TextStyle(color: Color(0xFF00E6D4)),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CustomPaint(painter: _AppBarCompassPainter()),
                  ),
                ),
              ),
              const TextSpan(
                text: 'MPASS',
                style: TextStyle(color: Color(0xFF00E6D4)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(() => ChatScreen());
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(100),
            // color: const Color.fromARGB(255, 3, 99, 163),
          ),
          height: 100,
          width: 70,
          child: Lottie.asset("assets/Tectarus Pulse.json", fit: BoxFit.cover),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 600;
          double horizontalPadding = isTablet ? 32.0 : 16.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 16.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                ), // Centers & limits width on large screens
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Progress Card
                    const _ProgressCard(),
                    const SizedBox(height: 28),

                    // 3. Quick Access Grid Section
                    const Text(
                      'Quick Access',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _QuickAccessGrid(isTablet: isTablet),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // 5. Bottom Navigation Bar
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF082135),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      // Use StreamBuilder to get live updates for tasks
      child: StreamBuilder<List<TaskModel>>(
        stream: FirebaseAuth.instance.currentUser == null
            ? const Stream.empty()
            : context.read<Taskprovider>().getTasks(),
        builder: (context, snapshot) {
          double percent = 0.0;
          int percentInt = 0;

          // ====== FETCH USER NAME FROM FIREBASE ======
          final user = FirebaseAuth.instance.currentUser;
          // Get the display name, fallback to 'User' if null
          final String fullName = user?.displayName ?? 'User';
          // Split by space to just get the first name
          final String firstName = fullName.split(' ').first;

          // Calculate daily progress
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final tasks = snapshot.data!;
            final now = DateTime.now();

            bool isToday(DateTime date) {
              return date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day;
            }

            final todayTasks = tasks.where((task) {
              return isToday(task.date ?? task.createdAt);
            }).toList();

            final total = todayTasks.length;
            final completed = todayTasks.where((t) => t.isCompleted).length;

            if (total > 0) {
              percent = completed / total;
              percentInt = (percent * 100).toInt();
            }
          }

          final progressColor = context.read<Taskprovider>().percentagecolor(
            percent,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // ====== USE THE EXTRACTED FIRST NAME ======
                'Hi, $firstName 👋',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ready to navigate your\ncareer path?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Circular Progress Indicator
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 85,
                        height: 85,
                        child: CircularProgressIndicator(
                          value: percent,
                          strokeWidth: 8,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progressColor,
                          ),
                        ),
                      ),
                      Text(
                        '$percentInt%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: percentInt > 0 ? progressColor : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  // Progress Info Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your today\'s goal Progress',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          percent >= 1.0
                              ? "Awesome! All tasks completed."
                              : "Keep going! You're doing great.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => Taskpageui(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Complete your goals... ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white24,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AppBarCompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;

    // --- GLOW ---
    final glow = Paint()
      ..color = const Color(0xFF00E6D4).withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, radius * 0.8, glow);

    // --- RINGS ---
    final brightRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFF00E6D4).withOpacity(0.85);

    final thinRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = const Color(0xFF00E6D4).withOpacity(0.2);

    canvas.drawCircle(center, radius * 0.80, brightRing);
    canvas.drawCircle(center, radius * 0.86, thinRing);
    canvas.drawCircle(center, radius * 0.62, thinRing);
    canvas.drawCircle(center, radius * 0.42, thinRing);

    // --- AXIS LINES ---
    final axisPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..color = const Color(0xFF00E6D4).withOpacity(0.35);

    final minD = radius * 0.15;
    final maxD = radius * 0.78;

    canvas.drawLine(
      Offset(center.dx, center.dy - maxD),
      Offset(center.dx, center.dy - minD),
      axisPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy + minD),
      Offset(center.dx, center.dy + maxD),
      axisPaint,
    );
    canvas.drawLine(
      Offset(center.dx - maxD, center.dy),
      Offset(center.dx - minD, center.dy),
      axisPaint,
    );
    canvas.drawLine(
      Offset(center.dx + minD, center.dy),
      Offset(center.dx + maxD, center.dy),
      axisPaint,
    );

    // --- DIAGONAL LINES ---
    final diagPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.4
      ..color = const Color(0xFF00E6D4).withOpacity(0.15);

    for (var angle in [45, 135, 225, 315]) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle * 3.1415926535 / 180);
      canvas.drawLine(Offset(0, -maxD * 0.9), Offset(0, -minD), diagPaint);
      canvas.restore();
    }

    // --- MAIN NEEDLES (4 cardinal) ---
    final mainLen = radius * 0.68;
    final mainW = radius * 0.10;
    _drawNeedle(canvas, center, mainLen, mainW, 0, const Color(0xFF00E6D4));
    _drawNeedle(canvas, center, mainLen, mainW, 90, const Color(0xFF00DEC9));
    _drawNeedle(canvas, center, mainLen, mainW, 180, const Color(0xFF00BFAF));
    _drawNeedle(canvas, center, mainLen, mainW, 270, const Color(0xFF00DEC9));

    // --- SUB NEEDLES (4 diagonal) ---
    final subLen = radius * 0.38;
    final subW = radius * 0.06;
    _drawNeedle(canvas, center, subLen, subW, 45, const Color(0xFF00A194));
    _drawNeedle(canvas, center, subLen, subW, 135, const Color(0xFF00A194));
    _drawNeedle(canvas, center, subLen, subW, 225, const Color(0xFF00A194));
    _drawNeedle(canvas, center, subLen, subW, 315, const Color(0xFF00A194));

    // --- CENTER ---
    canvas.drawCircle(
      center,
      radius * 0.08,
      Paint()..color = const Color(0xFF01141C),
    );

    final centerGlow = Paint()
      ..color = const Color(0xFF8BFFE3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center, radius * 0.045, centerGlow);
    canvas.drawCircle(center, radius * 0.02, Paint()..color = Colors.white);
  }

  void _drawNeedle(
    Canvas canvas,
    Offset center,
    double length,
    double baseWidth,
    double angleDeg,
    Color color,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angleDeg * 3.1415926535 / 180);

    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(-baseWidth, 0)
        ..lineTo(0, -length)
        ..close(),
      Paint()..color = color,
    );
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(baseWidth, 0)
        ..lineTo(0, -length)
        ..close(),
      Paint()..color = color.withOpacity(0.45),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// MARK: - Quick Access Grid
class _QuickAccessGrid extends StatelessWidget {
  final bool isTablet;
  const _QuickAccessGrid({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final List<VoidCallback> fun = [
      () => Get.to(
        () => const Taskpageui(),
        transition: Transition.rightToLeft,
      ), // goal tracker
      () => Get.to(
        () => const ChooseStreamScreen(),
        transition: Transition.rightToLeft,
      ), // explore careers
      () => Get.to(
        () => const InternshipDashboard(),
        transition: Transition.rightToLeft,
      ), // internship finder
    ];

    final items = [
      _GridItemData(
        'Goal tracker',
        "Set career goals, track progress, and stay on the path to success.",
        Icons.settings_outlined,
        const Color(0xFFFF9F43),
      ),
      _GridItemData(
        'Explore Careers',
        "Explore opportunities and find the right future for you.",
        Icons.explore_outlined,
        const Color(0xFF2196F3),
      ),
      _GridItemData(
        'Internship Finder',
        "Find internships that help you gain real-world experience and grow your skills.",
        Icons.work,
        const Color.fromARGB(255, 243, 54, 33),
      ),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: fun[index],
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF082135),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              // Using spacing property if you are on latest Flutter,
              // but standard is to handle spacing via padding/SizedBoxes.
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon with glowing shadow effect
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: item.color.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(item.icon, color: item.color, size: 22),
                ),
                const SizedBox(
                  width: 16,
                ), // Replaced 'spacing: 20' layout if standard Row
                // ====== FIXED OVERFLOW HERE ======
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, // Clean fallback wrap
                        style: const TextStyle(
                          fontSize:
                              12, // Reduced slightly for better visual hierarchy
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // =================================
                const SizedBox(width: 12),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white54,
                  size: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GridItemData {
  final String title;
  final IconData icon;
  final Color color;
  final String subtitle;
  _GridItemData(this.title, this.subtitle, this.icon, this.color);
}
