import 'package:flutter/material.dart';
import 'package:task_manager/model/task_model.dart';


class PriorityChip extends StatelessWidget {
  final Priority priority;
  const PriorityChip({super.key, required this.priority});

  Color get _bg {
    switch (priority) {
      case Priority.high:
        return const Color(0xFF2A100A);
      case Priority.medium:
        return const Color(0xFF252200);
      case Priority.low:
        return const Color(0xFF0A2016);
    }
  }

  Color get _fg {
    switch (priority) {
      case Priority.high:
        return const Color(0xFFD85A30);
      case Priority.medium:
        return const Color(0xFFE8C547);
      case Priority.low:
        return const Color(0xFF1D9E75);
    }
  }

  String get _label {
    switch (priority) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Med';
      case Priority.low:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          color: _fg,
        ),
      ),
    );
  }
}

// Usage anywhere in your task tile or task card:
// PriorityChip(priority: Priority.medium)
// PriorityChip(priority: Priority.high)
// PriorityChip(priority: Priority.low)
