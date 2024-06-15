import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/medication_entity.dart';

part 'medication_model.g.dart';

@JsonSerializable()
class MedicationModel extends MedicationEntity {
  const MedicationModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.daysOfWeek,
      required super.timesPerDay,
      required super.duration,
      required super.cause,
      required super.totalDoses,
      required super.doseType,
      required super.userId,
      required super.whoAdded,
      required super.doctorId,
      required super.dosesPerTimes,
      required super.frequencyType,
      required super.takeHistory});

  factory MedicationModel.fromJson(Map<String, dynamic> json) =>
      _$MedicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationModelToJson(this);

  factory MedicationModel.fromEntity(MedicationEntity e) => MedicationModel(
      id: e.id,
      title: e.title,
      description: e.description,
      daysOfWeek: e.daysOfWeek,
      timesPerDay: e.timesPerDay,
      duration: e.duration,
      cause: e.cause,
      totalDoses: e.totalDoses,
      doseType: e.doseType,
      userId: e.userId,
      whoAdded: e.whoAdded,
      doctorId: e.doctorId,
      dosesPerTimes: e.dosesPerTimes,
      frequencyType: e.frequencyType,
      takeHistory: e.takeHistory);
}
