import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hackathon/screen/resume_upload/controller/resume_upload_controller.dart';

class ResumeUploadScreen extends StatelessWidget {
  const ResumeUploadScreen({super.key});

  static const Color bgColor = Color(0xff051429);
  static const Color cardBgColor = Color(0xFF071324);
  static const Color textWhite = Colors.white;
  static const Color textMuted = Color(0xFF6B7A90);
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color borderDashedColor = Color(0xFF132D4A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          "CAREER COMPASS",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust margins and structural limits based on screen widths
          final double horizontalPadding = constraints.maxWidth > 700
              ? 48.0
              : 20.0;
          final int crossAxisCount = constraints.maxWidth > 900
              ? 3
              : (constraints.maxWidth > 600 ? 2 : 1);

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Glow Header Icon Area
                    Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              accentCyan.withOpacity(.25),
                              Colors.transparent,
                            ],
                          ),
                          border: Border.all(
                            color: accentCyan.withOpacity(.4),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.upload_file_outlined,
                          color: accentCyan,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    const Center(
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "Upload Your ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: "Resume",
                              style: TextStyle(color: accentCyan),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      "Upload your resume to get personalized career recommendations based on your skills and experience.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textMuted,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Interactive State Area
                    Consumer<ResumeUploadController>(
                      builder: (context, controller, child) {
                        if (controller.fileName.isNotEmpty) {
                          return _selectedFileCard(context, controller);
                        }
                        return _uploadArea(context);
                      },
                    ),
                    const SizedBox(height: 40),

                    // Tips Header Section
                    const Text(
                      "Tips for best results",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Responsive Tip Cards Layout that adapts to content height
                    LayoutBuilder(
                      builder: (context, gridConstraints) {
                        // If screen is wide, split into multi-column math; on mobile, take full width.
                        final double cardWidth = gridConstraints.maxWidth > 600
                            ? (gridConstraints.maxWidth - 32) /
                                  3 // 3 columns on wide screens (accounting for 16px spacing)
                            : gridConstraints.maxWidth; // Full width on mobile

                        return Wrap(
                          spacing: 16, // Horizontal space between cards
                          runSpacing: 16, // Vertical space between rows
                          children: [
                            SizedBox(
                              width: cardWidth,
                              child: _tipCard(
                                Icons.badge_outlined,
                                "Use Updated Resume",
                                "Make sure your resume is up to date with your latest details.",
                                const Color(0xFF6A1B9A),
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: _tipCard(
                                Icons.list_alt_rounded,
                                "Include Key Details",
                                "Mention core professional skills, unique projects, and education backgrounds.",
                                const Color(0xFF1565C0),
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: _tipCard(
                                Icons.track_changes_outlined,
                                "Highlight Achievements",
                                "Showcase measurable metrics and real-world impact goals.",
                                const Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _uploadArea(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.read<ResumeUploadController>().pickFile(),
        borderRadius: BorderRadius.circular(16),
        splashColor: accentCyan.withOpacity(0.05),
        highlightColor: accentCyan.withOpacity(0.02),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          decoration: BoxDecoration(
            color: cardBgColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderDashedColor, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_upload_outlined,
                color: accentCyan,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                "Drag & drop your resume here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text("or", style: TextStyle(color: textMuted)),
              const SizedBox(height: 12),

              // Refactored Button Wrapper to scale safely inside flexible layouts
              Container(
                height: 46,
                constraints: const BoxConstraints(maxWidth: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D2FF), Color(0xFF4A00E0)],
                  ),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<ResumeUploadController>().pickFile();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: const Text(
                    "Choose File",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Supports PDF only • Max size 5MB",
                style: TextStyle(color: textMuted, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _selectedFileCard(
    BuildContext context,
    ResumeUploadController controller,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF10243D), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accentCyan.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Interactive File List Item Layout
            Row(
              children: [
                // Glowing File Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.redAccent,
                    size: 36,
                  ),
                ),
                const SizedBox(width: 16),

                // File Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Neon ambient ready status line
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: 1.0,
                          minHeight: 3,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            accentCyan.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Interactive Trash/Cancel Option
                IconButton(
                  splashRadius: 22,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFEF5350),
                  ),
                  tooltip: 'Remove File',
                  onPressed: controller.onCancel,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Action buttons layout
            LayoutBuilder(
              builder: (context, btnConstraints) {
                final bool useFullWidthButtons = btnConstraints.maxWidth < 280;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.end,
                  children: [
                    SizedBox(
                      width: useFullWidthButtons ? double.infinity : 120,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: controller.onCancel,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: BorderSide(
                            color: Colors.redAccent.withOpacity(0.5),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: useFullWidthButtons ? double.infinity : 120,
                      height: 44,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: accentCyan.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => controller.onSubmit(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentCyan,
                            foregroundColor: bgColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.center_focus_weak, size: 18),
                              SizedBox(width: 6),
                              Text(
                                "Scan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget _tipCard(
    IconData icon,
    String title,
    String desc,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF10243D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min, // Forces column to shrink-wrap around elements
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(color: textMuted, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}
