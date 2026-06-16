import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class Taskpersentage {
  Widget dailyProgressCard({
    required int completed,
    required int total,
    required double percent,
  }) {
    // Dark Theme Colors Based on Design
    final Color cardColor = const Color(0xFF131826);
    final Color borderColor = const Color(0xFF262D47);
    final Color textPrimary = Colors.white;
    final Color textSecondary = const Color(0xFF8B95A5);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily Progress",
                  style: GoogleFonts.poppins(
                    color: textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  "$completed of $total Goals completed\nDo all Goals, it's mandatory",
                  style: GoogleFonts.poppins(
                    color: textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Consumer<Taskprovider>(
            builder: (context, taskprovider, child) {
              final color = taskprovider.percentagecolor(percent);

              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    // Adds a glowing effect matching the progress color
                    BoxShadow(
                      color: color.withValues(alpha: 0.25),
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: CircularPercentIndicator(
                  radius: 42,
                  lineWidth: 8,
                  percent: percent,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: borderColor, // Darker background track
                  progressColor: color,
                  center: Text(
                    "${(percent * 100).toInt()}%",
                    style: GoogleFonts.poppins(
                      color:
                          color, // Text color matches the glowing progress color
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
