import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Controller/all_provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/utils/app_constants.dart';
import 'package:task_manager/widgets/my_field.dart';
import 'package:task_manager/widgets/my_text.dart';

class EditTaskPage extends StatefulWidget {
  final TaskModel task;
  final int taskIndex;

  const EditTaskPage({super.key, required this.task, required this.taskIndex});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  int _selectedPriority = 1;

  final List<Map<String, dynamic>> _priorities = [
    {'label': 'High', 'color': const Color(0xFFD85A30)},
    {'label': 'Med', 'color': const Color(0xFFE8C547)},
    {'label': 'Low', 'color': const Color(0xFF1D9E75)},
  ];

  late final TextEditingController _taskCtrl;
  late final TextEditingController _durationCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _dateCtrl;
  late DateTime _selectedDate;
  final GlobalKey<FormState> _gKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _taskCtrl = TextEditingController(text: widget.task.task);
    _durationCtrl = TextEditingController(text: widget.task.days);
    _descCtrl = TextEditingController(text: widget.task.description);
    _selectedDate = widget.task.createdAt;
    _dateCtrl = TextEditingController(
      text: DateFormat('d MMMM, yyyy').format(widget.task.createdAt),
    );
    _selectedPriority = [
      Priority.high,
      Priority.medium,
      Priority.low,
    ].indexOf(widget.task.priority);
  }

  @override
  void dispose() {
    _taskCtrl.dispose();
    _durationCtrl.dispose();
    _descCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateCtrl.text = DateFormat('d MMMM, yyyy').format(picked);
      });
    }
  }

  void _save() {
    if (_taskCtrl.text.trim().isEmpty) return;

    final priorityMap = [Priority.high, Priority.medium, Priority.low];

    context.read<AllProvider>().editTask(
      index: widget.taskIndex,
      task: _taskCtrl.text.trim(),
      days: _durationCtrl.text.trim().isEmpty ? '1' : _durationCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      priority: priorityMap[_selectedPriority],
      date: _selectedDate,
    );

    AppConstants().showAppSnackbar(
      context,
      isError: false,
      message: 'Task updated successfully',
    );
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Form(
              key: _gKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Header
                  Row(
                    children: [
                      Container(
                        height: 26,
                        width: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8C547),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      MyText(
                        text: 'Edit Task',
                        size: 26,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF2A2A2A)),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Color(0xFF888888),
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  //Fields
                  MyField(
                    controller: _taskCtrl,
                    hint: 'What needs to be done?',
                    onTap: () {},
                    label: 'TASK',
                  ),
                  const SizedBox(height: 16),
                  MyField(
                    controller: _durationCtrl,
                    hint: 'e.g. 3',
                    label: 'DURATION (DAYS)',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  MyField(
                    controller: _dateCtrl,
                    hint: 'e.g. Apr 20, 2024',
                    label: 'DATE',
                    onTap: () => _selectDate(context),
                    openBoard: true,
                  ),
                  const SizedBox(height: 16),

                  //Priority
                  const MyText(
                    text: 'PRIORITY',
                    color: Color(0xFF888888),
                    size: 11,
                    weight: FontWeight.w600,
                    space: 1.5,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(_priorities.length, (index) {
                      final isSelected = _selectedPriority == index;
                      final color = _priorities[index]['color'] as Color;
                      final label = _priorities[index]['label'] as String;

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: index < _priorities.length - 1 ? 8 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPriority = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? color.withOpacity(0.12)
                                    : const Color(0xFF141414),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected
                                      ? color
                                      : const Color(0xFF2A2A2A),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: MyText(
                                  text: label,
                                  color: isSelected
                                      ? color
                                      : const Color(0xFF888888),
                                  size: 13,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 16),

                  MyField(
                    controller: _descCtrl,
                    hint: 'Any extra details..',
                    label: 'DESCRIPTION',
                    onTap: () {},
                    maxLines: 4,
                  ),

                  const SizedBox(height: 40),

                  //Save button
                  GestureDetector(
                    onTap: _save,
                    child: Container(
                      height: 52,
                      width: double.infinity,
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
                          text: 'SAVE CHANGES',
                          color: Colors.black,
                          weight: FontWeight.w700,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
