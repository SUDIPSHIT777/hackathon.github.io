import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/widget/snackbardesign.dart';
import 'package:provider/provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  bool isSelected = true;

  // Dark Theme Colors Based on Design
  final Color bgColor = const Color(0xFF0A0E17);
  final Color cardColor = const Color(0xFF131826);
  final Color borderColor = const Color(0xFF262D47);
  final Color primaryNeon = const Color(0xFF00E5FF);
  final Color secondaryNeon = const Color(0xFF2979FF);
  final Color textPrimary = Colors.white;
  final Color textSecondary = const Color(0xFF8B95A5);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "New Task",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Goal Title",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                _inputField(
                  controller: titleController,
                  hint: "What needs to be done?",
                  icon: Icons.edit_outlined,
                ),
                const SizedBox(height: 18),
                Text(
                  "Description",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                _inputField(
                  controller: descriptionController,
                  hint: "Add more details...",
                  icon: Icons.description_outlined,
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Selector<Taskprovider, DateTime?>(
                        selector: (_, provider) => provider.selectedDate,
                        builder: (context, selectedDate, _) {
                          return _dateTimeButton(
                            text: selectedDate == null
                                ? "Select Date"
                                : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            icon: Icons.calendar_today,
                            onTap: () =>
                                context.read<Taskprovider>().pickDate(context),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Selector<Taskprovider, TimeOfDay?>(
                        selector: (_, provider) => provider.selectedTime,
                        builder: (context, selectedTime, _) {
                          return _dateTimeButton(
                            text: selectedTime == null
                                ? "Select Time"
                                : selectedTime.format(context),
                            icon: Icons.access_time,
                            onTap: () =>
                                context.read<Taskprovider>().pickTime(context),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  "Priority Level",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Selector<Taskprovider, String>(
                  selector: (_, provider) => provider.priority,
                  builder: (context, priority, _) {
                    final priorities = ["low", "medium", "high"];
                    final controller = context.read<Taskprovider>();
                    return Row(
                      children: priorities.map((p) {
                        final isSelected = p == priority;
                        final priorityColor = controller.getPriorityColor(p);

                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.setPriority(p),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? priorityColor.withValues(alpha: 0.15)
                                    : cardColor,
                                border: Border.all(
                                  color: isSelected
                                      ? priorityColor
                                      : borderColor,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                p.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  color: isSelected
                                      ? priorityColor
                                      : textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [primaryNeon, secondaryNeon],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: secondaryNeon.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      final addController = context.read<Taskprovider>();

                      if (titleController.text.trim().isEmpty) return;

                      try {
                        await addController.addTask(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                        );
                        if (!mounted) return;
                        titleController.clear();
                        descriptionController.clear();
                        Navigator.pop(context);
                      } catch (e) {
                        if (!mounted) return;
                        Snackbardesign.showCustomSnackbar(
                          title: "Date Is Required",
                          subtitle: "Please Fill the Date",
                          backgroundColor: const Color(0xFFFF9800),
                          icon: Icons.error_outline,
                        );
                      }
                    },
                    child: Text(
                      "Create Goal",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      cursorColor: primaryNeon,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: textSecondary, fontSize: 14),
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderColor, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderColor, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryNeon, width: 1.5),
        ),
        prefixIcon: Icon(icon, color: textSecondary, size: 20),
      ),
    );
  }

  Widget _dateTimeButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: primaryNeon),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}

void openTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: const Color(0xFF0A0E17), // Darken the drag handle
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return const TaskBottomSheet();
    },
  );
}
