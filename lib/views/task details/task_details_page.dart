import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Controller/all_provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/utils/app_constants.dart';
import 'package:task_manager/widgets/my_text.dart';
import 'package:task_manager/widgets/priority_chip.dart';

import '../edit task/edit_task_page.dart';

class TaskDetailPage extends StatefulWidget {
  final TaskModel task;
  final int taskIndex;
  const TaskDetailPage({
    super.key,
    required this.task,
    required this.taskIndex,
  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    final progress = widget.task.progress;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            //Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF2A2A2A)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF888888),
                        size: 15,
                      ),
                    ),
                  ),
                  const Spacer(),
                  MyText(
                    text: 'Task Detail',
                    color: Colors.white,
                    size: 16,
                    weight: FontWeight.w600,
                  ),
                  const Spacer(),
                  // Edit button
                  GestureDetector(
                    onTap: () {
                      // Navigate to edit page with current task details
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EditTaskPage(
                            task: widget.task,
                            taskIndex: widget.taskIndex,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF2A2A2A)),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: Color(0xFF888888),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //task card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141414),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF2A2A2A)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  text: widget.task.task,
                                  color: Colors.white,
                                  size: 22,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              PriorityChip(priority: widget.task.priority),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Meta row
                          Row(
                            children: [
                              _MetaChip(
                                icon: Icons.calendar_today_outlined,
                                label: DateFormat(
                                  'MMM d, yyyy',
                                ).format(widget.task.createdAt),
                              ),
                              const SizedBox(width: 8),
                              _MetaChip(
                                icon: Icons.access_time,
                                label: widget.task.days,
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Progress
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(99),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 5,
                                    color: const Color(0xFFE8C547),
                                    backgroundColor: const Color(0xFF2A2A2A),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              MyText(
                                text: '${(progress * 100).toInt()}%',
                                color: const Color(0xFF888888),
                                size: 12,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    //Description
                    _SectionLabel(label: 'DESCRIPTION'),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141414),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF2A2A2A)),
                      ),
                      child: MyText(
                        text: widget.task.description,
                        // 'Design the full UI for the mobile app including all screens, components, and the design system documentation.',
                        color: const Color(0xFF888888),
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            //Bottom action
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  // Delete
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const MyText(text: 'Delete Task'),
                            content: const MyText(
                              text:
                                  'Are you sure you want to delete this task?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const MyText(text: 'CANCEL'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<AllProvider>().removeTask(
                                    widget.taskIndex,
                                  );
                                  Navigator.of(context).pop(); // close dialog
                                  Navigator.of(context).pop(); // go back
                                  AppConstants().showAppSnackbar(
                                    context,
                                    isError: true,
                                    message: 'Task deleted successfully',
                                  );
                                },
                                child: const MyText(
                                  text: 'DELETE',
                                  color: Color(0xFFD85A30),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF141414),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2A2A2A)),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xFFD85A30),
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Mark complete
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<AllProvider>().markAsCompleted(
                          widget.taskIndex,
                        );
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8C547),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE8C547).withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: MyText(
                            text: 'MARK AS COMPLETE',
                            color: Colors.black,
                            weight: FontWeight.w700,
                            size: 14,
                            space: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            //Check-in button
            GestureDetector(
              onTap: () {
                context.read<AllProvider>().checkIn(widget.taskIndex);
                setState(() {}); // refresh progress display
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                decoration: BoxDecoration(
                  color: widget.task.canCheckInToday
                      ? const Color(0xFF141414)
                      : const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.task.canCheckInToday
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFF1A1A1A),
                  ),
                ),
                child: Center(
                  child: MyText(
                    text: widget.task.canCheckInToday
                        ? 'WORKED ON THIS TODAY'
                        : 'ALREADY LOGGED TODAY',
                    color: widget.task.canCheckInToday
                        ? const Color(0xFFE8C547)
                        : const Color(0xFF444444),
                    weight: FontWeight.w700,
                    size: 13,
                    space: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Reusable section label
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return MyText(
      text: label,
      color: Color(0xFF888888),
      size: 11,
      weight: FontWeight.w600,
      space: 1.5,
    );
  }
}

//Reusable meta chip
class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 11, color: const Color(0xFF555555)),
          const SizedBox(width: 4),
          MyText(
            text: label,
            color: Color(0xFF555555),
            size: 11,
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
