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
      schedules:
          (json['schedules'] as List<dynamic>).map((e) => e as String).toList(),
      frequency: json['frequency'] as String,
      timesPerWeek: json['timesPerWeek'] as int,
      duration: json['duration'] as int,
    );

Map<String, dynamic> _$MedicationModelToJson(MedicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'schedules': instance.schedules,
      'frequency': instance.frequency,
      'timesPerWeek': instance.timesPerWeek,
      'duration': instance.duration,
    };
