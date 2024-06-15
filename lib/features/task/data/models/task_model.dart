import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/task_entity.dart';
part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends TaskEntity {
  const TaskModel(
      {required super.id,
      required super.whoAdded,
      required super.userId,
      required super.doctorId,
      required super.title,
      required super.description,
      required super.status,
      required super.progress,
      required super.completedMissions,
      required super.missions});

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromEntity(TaskEntity entity) => TaskModel(
      id: entity.id,
      whoAdded: entity.whoAdded,
      userId: entity.userId,
      doctorId: entity.doctorId,
      title: entity.title,
      description: entity.description,
      status: entity.status,
      progress: entity.progress,
      completedMissions: entity.completedMissions,
      missions: entity.missions);
}
