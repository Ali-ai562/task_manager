import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/views/task%20details/task_details_page.dart';
import 'package:task_manager/widgets/my_text.dart';
import 'package:task_manager/widgets/priority_chip.dart';

class PendingTasks extends StatelessWidget {
  final List<TaskModel> tasks;
  const PendingTasks({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time, color: Color(0xFF2A2A2A), size: 52),
            SizedBox(height: 12),
            Text(
              'No pending tasks',
              style: TextStyle(color: Color(0xFF555555), fontSize: 15),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final daysLeft = int.tryParse(task.days) ?? 0;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 400),
                reverseTransitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (_, animation, __) =>
                    TaskDetailPage(task: task, taskIndex: index),
                transitionsBuilder: (_, animation, __, child) {
                  return SlideTransition(
                    position:
                        Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                            .chain(CurveTween(curve: Curves.easeOut))
                            .animate(animation),
                    child: child,
                  );
                },
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF2A2A2A)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Animated pending indicator ──
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF252200),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE8C547),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.access_time,
                    color: Color(0xFFE8C547),
                    size: 18,
                  ),
                ),

                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: task.task,
                        color: Colors.white,
                        size: 16,
                        weight: FontWeight.w600,
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 11,
                            color: Color(0xFF555555),
                          ),
                          const SizedBox(width: 4),
                          MyText(
                            text: DateFormat(
                              'MMM d, yyyy',
                            ).format(task.createdAt),
                            color: const Color(0xFF555555),
                            size: 12,
                            weight: FontWeight.w400,
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.access_time,
                            size: 11,
                            color: Color(0xFF555555),
                          ),
                          const SizedBox(width: 4),
                          MyText(
                            text:
                                '$daysLeft day${daysLeft == 1 ? '' : 's'} left',
                            color: const Color(0xFF555555),
                            size: 12,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PriorityChip(priority: task.priority),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF252200),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE8C547)),
                      ),
                      child: const MyText(
                        text: 'In Progress',
                        color: Color(0xFFE8C547),
                        size: 11,
                        weight: FontWeight.w600,
                        space: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
