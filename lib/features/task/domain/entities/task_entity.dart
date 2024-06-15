// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String whoAdded;
  final String userId;
  final String doctorId;
  final String title;
  final String status;
  final String description;
  final int progress;
  final int completedMissions;
  
  final List<String> missions;
  const TaskEntity({
    required this.id,
    required this.whoAdded,
    required this.userId,
    required this.doctorId,
    required this.title,
    required this.status,
    required this.description,
    required this.progress,
    required this.completedMissions,
    required this.missions,
  });

  @override
  List<Object> get props {
    return [
      id,
      whoAdded,
      userId,
      doctorId,
      title,
      status,
      description,
      progress,
      completedMissions,
      missions,
    ];
  }

  TaskEntity copyWith({
    String? id,
    String? whoAdded,
    String? userId,
    String? doctorId,
    String? title,
    String? status,
    String? description,
    int? progress,
    int? completedMissions,
    List<String>? missions,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      whoAdded: whoAdded ?? this.whoAdded,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      title: title ?? this.title,
      status: status ?? this.status,
      description: description ?? this.description,
      progress: progress ?? this.progress,
      completedMissions: completedMissions ?? this.completedMissions,
      missions: missions ?? this.missions,
    );
  }
}
