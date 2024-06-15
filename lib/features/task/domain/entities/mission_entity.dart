// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MissionEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String dateTime;
  final String taskId;
  final bool isCompleted;
  const MissionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.taskId,
    required this.isCompleted,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      dateTime,
      taskId,
      isCompleted,
    ];
  }

  MissionEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? dateTime,
    String? taskId,
    bool? isCompleted,
  }) {
    return MissionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      taskId: taskId ?? this.taskId,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
