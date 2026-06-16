import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/controller/userprovider.dart';
import 'package:hackathon/screen/tasks/model/taskmodel.dart';
import 'package:hackathon/screen/tasks/ui/taskaddui.dart';
import 'package:hackathon/screen/tasks/widget/completed.dart';
import 'package:hackathon/screen/tasks/widget/snackbardesign.dart';
import 'package:hackathon/screen/tasks/widget/taskpersentage.dart';
import 'package:lottie/lottie.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
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
                        title: "Task Completed",
                        subtitle: "Congratulations You completed your task",
                        backgroundColor: Color(0xFF00c247),
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

              const SizedBox(height: 18),

              // ================== TAB BAR ==================
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.blue.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey.shade600,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xff4F46E5), Color(0xff7C3AED)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff7C3AED).withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: -15),
                  tabs: const [
                    Tab(text: "All Tasks"),
                    Tab(text: "Completed"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                          return Center(child: CircularProgressIndicator());
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
                                const SizedBox(height: 12),
                                Text("data"),
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
                                Text(
                                  taskprovider.formatDate(date),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: dateTasks.length,
                                  padding: const EdgeInsets.all(12),
                                  itemBuilder: (context, index) {
                                    final task = dateTasks[index];

                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.2,
                                              child: Checkbox(
                                                value: task.isCompleted,
                                                onChanged: (_) async {
                                                  await taskprovider.toggleTask(
                                                    task,
                                                  );
                                                  if (task.isCompleted) {
                                                    taskprovider.playAudio();
                                                  }
                                                },
                                                checkColor: Colors.white,
                                                activeColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    task.title,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      decoration:
                                                          task.isCompleted
                                                          ? TextDecoration
                                                                .lineThrough
                                                          : null,
                                                      color: task.isCompleted
                                                          ? Colors.grey
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/calendar.png",
                                                        scale: 25,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        task.date != null
                                                            ? "${task.date!.day}/${task.date!.month}/${task.date!.year}"
                                                            : "No date",
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Image.asset(
                                                        "assets/waste.png",
                                                        scale: 25,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        task.time?.format(
                                                              context,
                                                            ) ??
                                                            "No time",
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Consumer<Taskprovider>(
                                              builder: (context, taskcolor, _) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 5,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: taskcolor
                                                        .getPriorityColor(
                                                          task.priority,
                                                        )
                                                        .withValues(
                                                          alpha: 0.15,
                                                        ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
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
                                                        color: taskcolor
                                                            .getPriorityColor(
                                                              task.priority,
                                                            ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        task.priority
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: taskcolor
                                                              .getPriorityColor(
                                                                task.priority,
                                                              ),
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1976ED),
        onPressed: () {
          openTaskBottomSheet(context);
        },
        child: Icon(Icons.add_circle, size: 28, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
