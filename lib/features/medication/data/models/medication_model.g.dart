// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicationModel _$MedicationModelFromJson(Map<String, dynamic> json) =>
    MedicationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      timesPerDay: (json['timesPerDay'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      cause: json['cause'] as String,
      totalDoses: (json['totalDoses'] as num).toInt(),
      doseType: json['doseType'] as String,
      userId: json['userId'] as String,
      whoAdded: json['whoAdded'] as String,
      doctorId: json['doctorId'] as String,
      dosesPerTimes: (json['dosesPerTimes'] as num).toInt(),
      frequencyType: json['frequencyType'] as String,
      takeHistory: (json['takeHistory'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$MedicationModelToJson(MedicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'whoAdded': instance.whoAdded,
      'userId': instance.userId,
      'doctorId': instance.doctorId,
      'cause': instance.cause,
      'doseType': instance.doseType,
      'frequencyType': instance.frequencyType,
      'totalDoses': instance.totalDoses,
      'dosesPerTimes': instance.dosesPerTimes,
      'duration': instance.duration,
      'timesPerDay': instance.timesPerDay,
      'takeHistory': instance.takeHistory,
      'daysOfWeek': instance.daysOfWeek,
    };
