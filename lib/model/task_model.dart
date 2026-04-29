import 'package:hive_ce/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
enum Priority {
  @HiveField(0)
  high,
  @HiveField(1)
  medium,
  @HiveField(2)
  low,
}

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String task;

  @HiveField(1)
  String days;

  @HiveField(2)
  String description;

  @HiveField(3)
  Priority priority;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  bool isCompleted;

  @HiveField(6)
  double progress;

  @HiveField(7)
  int checkIns;

  @HiveField(8)
  DateTime? lastCheckIn;

  TaskModel({
    required this.task,
    required this.days,
    required this.description,
    required this.priority,
    required this.createdAt,
    this.isCompleted = false,
    this.progress = 0.0,
    this.checkIns = 0,
    this.lastCheckIn,
  });

  //Derived
  int get targetDays => int.tryParse(days) ?? 1;

  bool get canCheckInToday {
    if (lastCheckIn == null) return true;
    final now = DateTime.now();
    return !(lastCheckIn!.year == now.year &&
        lastCheckIn!.month == now.month &&
        lastCheckIn!.day == now.day);
  }
}
