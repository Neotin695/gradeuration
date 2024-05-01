import 'package:gradeuration/features/medication/domain/entities/medication_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medication_model.g.dart';

@JsonSerializable()
class MedicationModel extends MedicationEntity {
  const MedicationModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.schedules,
      required super.frequency,
      required super.timesPerWeek,
      required super.duration,
      required super.cause,
      required super.pill,
      required super.type,
      required super.taken});

  factory MedicationModel.fromJson(Map<String, dynamic> json) =>
      _$MedicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationModelToJson(this);
}
