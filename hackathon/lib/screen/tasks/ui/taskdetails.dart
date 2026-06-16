import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/tasks/controller/allupdatefunction.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/model/taskmodel.dart';
import 'package:provider/provider.dart';

class Taskdetails extends StatefulWidget {
  final TaskModel alltaskdetails;
  const Taskdetails({super.key, required this.alltaskdetails});

  @override
  State<Taskdetails> createState() => _TaskdetailsState();
}

class _TaskdetailsState extends State<Taskdetails> {
  late TextEditingController titleController;
  late TextEditingController descController;

  // Dark Theme Colors Based on Design
  final Color bgColor = const Color(0xFF0A0E17);
  final Color cardColor = const Color(0xFF131826);
  final Color borderColor = const Color(0xFF262D47);
  final Color primaryNeon = const Color(0xFF00E5FF);
  final Color secondaryNeon = const Color(0xFF2979FF);
  final Color textPrimary = Colors.white;
  final Color textSecondary = const Color(0xFF8B95A5);

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.alltaskdetails.title);
    descController = TextEditingController(text: widget.alltaskdetails.desc);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DateTimeProvider>().setInitial(
        widget.alltaskdetails.date,
        widget.alltaskdetails.time,
      );
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<Taskprovider>();
    final priorityColor = taskProvider.getPriorityColor(
      widget.alltaskdetails.priority,
    );

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Task Details",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: textPrimary, size: 20),
        ),
      ),

      /// ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      cursorColor: primaryNeon,
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                        height: 1.3,
                      ),
                      decoration: InputDecoration(
                        hintText: "Task title...",
                        hintStyle: GoogleFonts.poppins(
                          color: textSecondary.withValues(alpha: 0.5),
                        ),
                        border: InputBorder.none,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: priorityColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: priorityColor.withValues(alpha: 0.5),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            taskProvider.getPriorityIcon(
                              widget.alltaskdetails.priority,
                            ),
                            size: 16,
                            color: priorityColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.alltaskdetails.priority.toUpperCase(),
                            style: GoogleFonts.poppins(
                              color: priorityColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// DESCRIPTION
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 1.2),
                      ),
                      child: TextField(
                        controller: descController,
                        maxLines: 5,
                        cursorColor: primaryNeon,
                        style: GoogleFonts.poppins(
                          color: textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText: "Add description...",
                          hintStyle: GoogleFonts.poppins(color: textSecondary),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// ================= Date + Time =================
                    Consumer<DateTimeProvider>(
                      builder: (context, dateProvider, _) {
                        return Row(
                          children: [
                            Expanded(
                              child: _buildThemedDateTimeCard(
                                icon: Icons.calendar_today,
                                label: "Date",
                                value: dateProvider.formatDate(),
                                onTap: () => dateProvider.pickDate(context),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildThemedDateTimeCard(
                                icon: Icons.access_time,
                                label: "Time",
                                value: dateProvider.formatTime(),
                                onTap: () => dateProvider.pickTime(context),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    /// STATUS
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 1.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                widget.alltaskdetails.isCompleted
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: widget.alltaskdetails.isCompleted
                                    ? primaryNeon
                                    : textSecondary,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Task Status",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: textPrimary,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          CupertinoSwitch(
                            value: widget.alltaskdetails.isCompleted,
                            activeColor: primaryNeon,
                            trackColor: borderColor,
                            onChanged:
                                (
                                  _,
                                ) {}, // Assuming read-only in details view based on original code
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            /// ================= Buttons =================
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFEF4444,
                        ).withValues(alpha: 0.1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFFEF4444),
                            width: 1.5,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await taskProvider.deletetask(widget.alltaskdetails.id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Delete",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFEF4444),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 56,
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
                        final dateProvider = context.read<DateTimeProvider>();

                        await taskProvider.updatetask(
                          taskid: widget.alltaskdetails.id,
                          title: titleController.text.trim(),
                          description: descController.text.trim(),
                          date: dateProvider.selectedDate,
                          time: dateProvider.selectedTime,
                        );

                        Navigator.pop(context);
                      },
                      child: Text(
                        "Update Task",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Bottom padding for safe area
          ],
        ),
      ),
    );
  }

  // Themed replacement for buildDateTimeCard
  Widget _buildThemedDateTimeCard({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: textSecondary),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
