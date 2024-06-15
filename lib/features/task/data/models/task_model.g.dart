// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String,
      whoAdded: json['whoAdded'] as String,
      userId: json['userId'] as String,
      doctorId: json['doctorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      progress: (json['progress'] as num).toInt(),
      completedMissions: (json['completedMissions'] as num).toInt(),
      missions:
          (json['missions'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'whoAdded': instance.whoAdded,
      'userId': instance.userId,
      'doctorId': instance.doctorId,
      'title': instance.title,
      'status': instance.status,
      'description': instance.description,
      'progress': instance.progress,
      'completedMissions': instance.completedMissions,
      'missions': instance.missions,
    };
