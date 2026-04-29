// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final typeId = 1;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      task: fields[0] as String,
      days: fields[1] as String,
      description: fields[2] as String,
      priority: fields[3] as Priority,
      createdAt: fields[4] as DateTime,
      isCompleted: fields[5] == null ? false : fields[5] as bool,
      progress: fields[6] == null ? 0.0 : (fields[6] as num).toDouble(),
      checkIns: fields[7] == null ? 0 : (fields[7] as num).toInt(),
      lastCheckIn: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.progress)
      ..writeByte(7)
      ..write(obj.checkIns)
      ..writeByte(8)
      ..write(obj.lastCheckIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PriorityAdapter extends TypeAdapter<Priority> {
  @override
  final typeId = 0;

  @override
  Priority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Priority.high;
      case 1:
        return Priority.medium;
      case 2:
        return Priority.low;
      default:
        return Priority.high;
    }
  }

  @override
  void write(BinaryWriter writer, Priority obj) {
    switch (obj) {
      case Priority.high:
        writer.writeByte(0);
      case Priority.medium:
        writer.writeByte(1);
      case Priority.low:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
