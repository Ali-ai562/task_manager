import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/widgets/my_text.dart';

class CompletedTasks extends StatelessWidget {
  final List<TaskModel> tasks;
  const CompletedTasks({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Color(0xFF2A2A2A),
              size: 52,
            ),
            SizedBox(height: 12),
            Text(
              'No completed tasks',
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
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF1E1E1E)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Green check circle ──
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A2016),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF1D9E75),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF1D9E75),
                  size: 18,
                ),
              ),

              const SizedBox(width: 14),

              // ── Title + meta ──
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: task.task,
                      color: Color(0xFF555555),
                      size: 16,
                      weight: FontWeight.w600,
                      decoration: TextDecoration.lineThrough,
                      decColor: Color(0xFF555555),
                      decthick: 1.5,
                    ),

                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 11,
                          color: Color(0xFF444444),
                        ),
                        const SizedBox(width: 4),
                        MyText(
                          text: DateFormat(
                            'MMM d, yyyy',
                          ).format(task.createdAt),
                          color: Color(0xFF444444),
                          size: 12,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: MyText(
                            text: 'Design',
                            color: Color(0xFF444444),
                            size: 11,
                          ),
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
                  // PriorityChip(priority: Priority.high),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A2016),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF1D9E75)),
                    ),
                    child: MyText(
                      text: 'Done',
                      color: Color(0xFF1D9E75),
                      size: 11,
                      weight: FontWeight.w600,
                      space: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
