import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/ui/taskdetails.dart';
import 'package:hackathon/screen/tasks/widget/deletetask.dart';
import 'package:provider/provider.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    // Dark Theme Colors Based on Design
    final Color cardColor = const Color(0xFF131826);
    final Color borderColor = const Color(0xFF262D47);
    final Color primaryNeon = const Color(0xFF00E5FF);
    final Color textPrimary = Colors.white;
    final Color textSecondary = const Color(0xFF8B95A5);

    return Consumer<Taskprovider>(
      builder: (context, taskprovider, child) {
        final completedTasks = taskprovider.tasks
            .where((task) => task.isCompleted)
            .toList();

        if (completedTasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.task_alt, size: 60, color: borderColor),
                const SizedBox(height: 16),
                Text(
                  "No completed tasks yet",
                  style: GoogleFonts.poppins(
                    color: textSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 80,
          ), // Padding so FAB doesn't block last item
          itemCount: completedTasks.length,
          itemBuilder: (context, index) {
            final task = completedTasks[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Taskdetails(alltaskdetails: task),
                ),
              ),
              onLongPress: () => confirmDelete(context, task.id),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) {
                        taskprovider.toggleTask(task);
                      },
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return primaryNeon;
                        }
                        return Colors.transparent;
                      }),
                      side: WidgetStateBorderSide.resolveWith((states) {
                        return BorderSide(
                          color: states.contains(WidgetState.selected)
                              ? primaryNeon
                              : textSecondary,
                          width: 1.5,
                        );
                      }),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              // Dim the text slightly since it's a completed task
                              color: task.isCompleted
                                  ? textSecondary
                                  : textPrimary,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: textSecondary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                task.date != null
                                    ? "${task.date!.day}/${task.date!.month}/${task.date!.year}"
                                    : "No date",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: textSecondary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: textSecondary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                task.time?.format(context) ?? "No time",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: textSecondary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Consumer<Taskprovider>(
                      builder: (context, taskcolor, _) {
                        final priorityColor = taskcolor.getPriorityColor(
                          task.priority,
                        );
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: priorityColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: priorityColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                taskcolor.getPriorityIcon(task.priority),
                                size: 14,
                                color: priorityColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                task.priority.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: priorityColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
