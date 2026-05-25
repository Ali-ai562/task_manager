import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Controller/all_provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/views/task%20details/task_details_page.dart';
import 'package:task_manager/widgets/my_text.dart';
import 'package:task_manager/widgets/priority_chip.dart';

class AllTasks extends StatelessWidget {
  final List<TaskModel> tasks;
  const AllTasks({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.assignment_outlined, color: Color(0xFF2A2A2A), size: 52),
            SizedBox(height: 12),
            Text(
              'No tasks yet',
              style: TextStyle(color: Color(0xFF555555), fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final daysLeft = int.tryParse(task.days) ?? 0;

        return GestureDetector(
          onLongPress: () {
            // Delete confirmation dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Task'),
                content: const Text(
                  'Are you sure you want to delete this task?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const MyText(text: 'Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AllProvider>().removeTask(index);
                      Navigator.pop(context);
                    },
                    child: const MyText(text: 'Delete', color: Colors.red),
                  ),
                ],
              ),
            );
          },
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 400),
                reverseTransitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (_, animation, _) =>
                    TaskDetailPage(task: task, taskIndex: index),
                transitionsBuilder: (_, animation, _, child) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title + Priority
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MyText(
                        text: task.task,
                        color: Colors.white,
                        size: 17,
                        weight: FontWeight.w600,
                      ),
                    ),
                    PriorityChip(priority: task.priority),
                  ],
                ),

                const SizedBox(height: 6),

                //Date
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Color(0xFF555555),
                    ),
                    const SizedBox(width: 4),
                    MyText(
                      text: DateFormat('MMM d, yyyy').format(task.createdAt),
                      color: const Color(0xFF555555),
                      size: 12,
                      weight: FontWeight.w300,
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF555555),
                    ),
                    const SizedBox(width: 4),
                    MyText(
                      text: '$daysLeft day${daysLeft == 1 ? '' : 's'} left',
                      color: const Color(0xFF555555),
                      size: 12,
                      weight: FontWeight.w300,
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                //Progress
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: task.progress, //
                          color: const Color(0xFFE8C547),
                          backgroundColor: const Color(0xFF2A2A2A),
                          minHeight: 5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    MyText(
                      text: '${(task.progress * 100).toInt()}%',
                      color: const Color(0xFF888888),
                      size: 12,
                      weight: FontWeight.w400,
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
