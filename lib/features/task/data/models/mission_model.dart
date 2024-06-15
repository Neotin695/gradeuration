import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/mission_entity.dart';
part 'mission_model.g.dart';

@JsonSerializable()
class MissionModel extends MissionEntity {
  const MissionModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.dateTime,
      required super.isCompleted,
      required super.taskId});

  factory MissionModel.fromJson(Map<String, dynamic> json) =>
      _$MissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$MissionModelToJson(this);

  factory MissionModel.fromEntity(MissionEntity e) => MissionModel(
      id: e.id,
      title: e.title,
      description: e.description,
      dateTime: e.dateTime,
      isCompleted: e.isCompleted,
      taskId: e.taskId);
}
