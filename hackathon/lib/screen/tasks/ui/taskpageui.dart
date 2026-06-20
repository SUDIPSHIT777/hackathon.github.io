import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/model/taskmodel.dart';
import 'package:hackathon/screen/tasks/ui/taskaddui.dart';
import 'package:hackathon/screen/tasks/ui/taskdetails.dart';
import 'package:hackathon/screen/tasks/widget/completed.dart';
import 'package:hackathon/screen/tasks/widget/snackbardesign.dart';
import 'package:hackathon/screen/tasks/widget/taskpersentage.dart';
import 'package:provider/provider.dart';

class Taskpageui extends StatefulWidget {
  const Taskpageui({super.key});

  @override
  State<Taskpageui> createState() => _TaskpageuiState();
}

class _TaskpageuiState extends State<Taskpageui>
    with SingleTickerProviderStateMixin {
  final taskpersentage = Taskpersentage();
  late TabController _tabController;

  bool _snackbarShown = false;

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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "GOALS",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),

        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // ================== PROGRESS ==================
              StreamBuilder<List<TaskModel>>(
                stream: FirebaseAuth.instance.currentUser == null
                    ? const Stream.empty()
                    : context.read<Taskprovider>().getTasks(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return taskpersentage.dailyProgressCard(
                      completed: 0,
                      total: 0,
                      percent: 0,
                    );
                  }

                  final tasks = snapshot.data!;

                  bool isToday(DateTime date) {
                    final now = DateTime.now();
                    return date.year == now.year &&
                        date.month == now.month &&
                        date.day == now.day;
                  }

                  final todayTasks = tasks.where((task) {
                    return isToday(task.date ?? task.createdAt);
                  }).toList();

                  final todayTotal = todayTasks.length;
                  final todayCompleted = todayTasks
                      .where((t) => t.isCompleted)
                      .length;

                  final todayPercent = todayTotal == 0
                      ? 0
                      : todayCompleted / todayTotal;

                  if (todayPercent >= 1.0 && !_snackbarShown) {
                    _snackbarShown = true;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Snackbardesign.showCustomSnackbar(
                        title: "Goal Completed",
                        subtitle: "Congratulations You completed your Goal",
                        backgroundColor: const Color(0xFF00c247),
                        icon: Icons.download_done_rounded,
                      );
                    });
                  }

                  return taskpersentage.dailyProgressCard(
                    completed: todayCompleted,
                    total: todayTotal,
                    percent: todayPercent.toDouble(),
                  );
                },
              ),

              const SizedBox(height: 20),

              // ================== TAB BAR ==================
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: TabBar(
                  controller: _tabController,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  dividerColor: Colors.transparent,
                  labelColor: textPrimary,
                  unselectedLabelColor: textSecondary,
                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [primaryNeon, secondaryNeon],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: secondaryNeon.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: -15),
                  tabs: const [
                    Tab(text: "All Goals"),
                    Tab(text: "Completed"),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // ================== TAB VIEWS ==================
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    StreamBuilder<List<TaskModel>>(
                      stream: FirebaseAuth.instance.currentUser == null
                          ? const Stream.empty()
                          : context.read<Taskprovider>().getTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: primaryNeon,
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.read<Taskprovider>().setTasks(
                              snapshot.data!,
                            );
                          });
                        }

                        final tasks = snapshot.hasData
                            ? snapshot.data!
                                  .where((task) => !task.isCompleted)
                                  .toList()
                            : <TaskModel>[];

                        if (tasks.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.task_alt,
                                  size: 60,
                                  color: borderColor,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "No Goal pending",
                                  style: GoogleFonts.poppins(
                                    color: textSecondary,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        final taskprovider = context.read<Taskprovider>();
                        final groupedTasks = taskprovider.groupTasks(tasks);
                        final dates = groupedTasks.keys.toList();
                        dates.sort((a, b) => a.compareTo(b));

                        return ListView.builder(
                          itemCount: dates.length,
                          itemBuilder: (context, index) {
                            final date = dates[index];
                            final dateTasks = groupedTasks[date]!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4.0,
                                    bottom: 8.0,
                                    top: 8.0,
                                  ),
                                  child: Text(
                                    taskprovider.formatDate(date),
                                    style: GoogleFonts.poppins(
                                      color: primaryNeon,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: dateTasks.length,
                                  padding: const EdgeInsets.only(bottom: 12),
                                  itemBuilder: (context, index) {
                                    final task = dateTasks[index];

                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Taskdetails(alltaskdetails: task),
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: cardColor,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: borderColor,
                                            width: 1.2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.2,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: task.isCompleted,
                                              onChanged: (_) async {
                                                await taskprovider.toggleTask(
                                                  task,
                                                );
                                              },
                                              fillColor:
                                                  WidgetStateProperty.resolveWith(
                                                    (states) {
                                                      if (states.contains(
                                                        WidgetState.selected,
                                                      )) {
                                                        return primaryNeon;
                                                      }
                                                      return Colors.transparent;
                                                    },
                                                  ),
                                              side:
                                                  WidgetStateBorderSide.resolveWith(
                                                    (states) {
                                                      return BorderSide(
                                                        color:
                                                            states.contains(
                                                              WidgetState
                                                                  .selected,
                                                            )
                                                            ? primaryNeon
                                                            : textSecondary,
                                                        width: 1.5,
                                                      );
                                                    },
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    task.title,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration:
                                                          task.isCompleted
                                                          ? TextDecoration
                                                                .lineThrough
                                                          : null,
                                                      color: task.isCompleted
                                                          ? textSecondary
                                                          : textPrimary,
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
                                                      Flexible(
                                                        flex: 2,
                                                        child: Text(
                                                          task.date != null
                                                              ? "${task.date!.day}/${task.date!.month}/${task.date!.year}"
                                                              : "No date",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                color:
                                                                    textSecondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Icon(
                                                        Icons.access_time,
                                                        size: 12,
                                                        color: textSecondary,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Flexible(
                                                        child: Text(
                                                          task.time?.format(
                                                                context,
                                                              ) ??
                                                              "No time",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                color:
                                                                    textSecondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Consumer<Taskprovider>(
                                              builder: (context, taskcolor, _) {
                                                final priorityColor = taskcolor
                                                    .getPriorityColor(
                                                      task.priority,
                                                    );
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 6,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: priorityColor
                                                        .withValues(
                                                          alpha: 0.15,
                                                        ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    border: Border.all(
                                                      color: priorityColor
                                                          .withValues(
                                                            alpha: 0.3,
                                                          ),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        taskcolor
                                                            .getPriorityIcon(
                                                              task.priority,
                                                            ),
                                                        size: 14,
                                                        color: priorityColor,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        task.priority
                                                            .toUpperCase(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  priorityColor,
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
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const Completed(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [primaryNeon, secondaryNeon],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: secondaryNeon.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            openTaskBottomSheet(context);
          },
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
