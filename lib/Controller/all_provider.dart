import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:task_manager/model/task_model.dart';

class AllProvider with ChangeNotifier {
  final Box<TaskModel> _box = Hive.box<TaskModel>('tasksBox');
  List<TaskModel> get tasks => _box.values.toList();

  //Filtered lists for tabs
  List<TaskModel> get pendingTasks =>
      tasks.where((t) => !t.isCompleted && t.progress < 1.0).toList();

  List<TaskModel> get inProgressTasks => tasks
      .where((t) => !t.isCompleted && t.progress > 0.0 && t.progress < 1.0)
      .toList();

  List<TaskModel> get completedTasks =>
      tasks.where((t) => t.isCompleted || t.progress >= 1.0).toList();

  int get totalCount => tasks.length;
  int get completedCount => completedTasks.length;
  int get pendingCount => pendingTasks.length;
  

  //Add task
  void addTask({
    required String task,
    required String days,
    required String description,
    required Priority priority,
  }) {
    final newTask = TaskModel(
      task: task,
      days: days,
      description: description,
      priority: priority,
      createdAt: DateTime.now(),
    );

    _box.add(newTask);
    notifyListeners();
  }

  //Edit task
  void editTask({
    required int index,
    required String task,
    required String days,
    required DateTime date,
    required String description,
    required Priority priority,
  }) {
    final existingTask = _box.getAt(index);
    if (existingTask == null) return;

    existingTask.task = task;
    existingTask.days = days;
    existingTask.description = description;
    existingTask.priority = priority;
    existingTask.createdAt = date;
    existingTask.save();
    notifyListeners();
  }

  //Toggle complete
  void toggleTaskCompletion(int index) {
    final task = _box.getAt(index);
    if (task == null) return;

    task.isCompleted = !task.isCompleted;
    task.save();
    notifyListeners();
  }

  //Check-in (progress)
  void checkIn(int index) {
    final task = _box.getAt(index);
    if (task == null) return;
    if (!task.canCheckInToday) return;

    task.checkIns += 1;
    task.lastCheckIn = DateTime.now();
    task.progress = (task.checkIns / task.targetDays).clamp(0.0, 1.0);

    if (task.progress >= 1.0) task.isCompleted = true;

    task.save();
    notifyListeners();
  }

  // Delete
  void removeTask(int index) {
    _box.deleteAt(index);
    notifyListeners();
  }

  //Search
  List<TaskModel> searchTasks(String query) {
    final q = query.toLowerCase();
    return tasks.where((task) {
      return task.task.toLowerCase().contains(q);
    }).toList();
  }

  //Search pending
  List<TaskModel> searchPendingTasks(String query) {
    final q = query.toLowerCase();
    return pendingTasks.where((task) {
      return task.task.toLowerCase().contains(q);
    }).toList();
  }

  //Search completed
  List<TaskModel> searchCompletedTasks(String query) {
    final q = query.toLowerCase();
    return completedTasks.where((task) {
      return task.task.toLowerCase().contains(q);
    }).toList();
  }

  // Mark as completed manually
  void markAsCompleted(int index) {
    final task = _box.getAt(index);
    if (task == null) return;

    task.isCompleted = true;
    task.progress = 1.0;
    task.save();
    notifyListeners();
  }
}
