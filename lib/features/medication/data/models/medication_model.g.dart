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
      cause: json['cause'] as String,
      pill: json['pill'] as int,
      type: json['type'] as String,
      taken: json['taken'] as int,
    );

Map<String, dynamic> _$MedicationModelToJson(MedicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'cause': instance.cause,
      'frequency': instance.frequency,
      'timesPerWeek': instance.timesPerWeek,
      'pill': instance.pill,
      'type': instance.type,
      'duration': instance.duration,
      'taken': instance.taken,
      'schedules': instance.schedules,
    };
