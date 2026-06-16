import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/internship/ui/internship.dart';
import 'package:hackathon/screen/resume_upload/resume_upload_screen.dart';
import 'package:hackathon/screen/explore_careers/stream_chooser/exploer_careers_screen.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/model/taskmodel.dart';
import 'package:hackathon/screen/tasks/ui/taskpageui.dart';
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
        centerTitle: true,
        backgroundColor: const Color(0xff051429),
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xff051429),
          // Replace with your NetworkImage asset
          backgroundImage: AssetImage('assets/appLogoOnly.png'),
        ),
        title: Text(
          "CAREER COMPASS",
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 18,
          ),
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
                          'Your Progress',
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
                              () => const Taskpageui(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'View Details ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white24,
                    size: 16,
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

// MARK: - Quick Access Grid
class _QuickAccessGrid extends StatelessWidget {
  final bool isTablet;
  const _QuickAccessGrid({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    // Dynamic item styling parameters
    final List<VoidCallback> fun = [
      () => Get.to(
        () => const ResumeUploadScreen(),
        transition: Transition.rightToLeft,
      ), // resume analysis
      () => Get.to(
        () => const Taskpageui(),
        transition: Transition.rightToLeft,
      ), // skill gap assment
      () => Get.to(
        () => const ChooseStreamScreen(),
        transition: Transition.rightToLeft,
      ), // explore careers
      () => Get.to(
        () => const InternshipDashboard(),
        transition: Transition.rightToLeft,
      ), // intership finder
    ];
    final items = [
      _GridItemData(
        'Resume\nAnalysis',
        Icons.assignment_outlined,
        const Color(0xFF00E5BC),
      ),
      _GridItemData(
        'Skill Gap\nAssessment',
        Icons.settings_outlined,
        const Color(0xFFFF9F43),
      ),
      _GridItemData(
        'Explore\nCareers',
        Icons.explore_outlined,
        const Color(0xFF2196F3),
      ),
      _GridItemData('Internship\nFinder', Icons.work, const Color(0xFF2196F3)),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // Adjust column count dynamically for responsiveness
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 4 : 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: isTablet ? 1.2 : 1.35,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: fun[index],
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF082135),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.2,
                  ),
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
  _GridItemData(this.title, this.icon, this.color);
}
