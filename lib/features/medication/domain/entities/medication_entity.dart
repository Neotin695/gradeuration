// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MedicationEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final int schedules;
  final String frequency;
  final int timesPerWeek;
  final int duration;
  const MedicationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.schedules,
    required this.frequency,
    required this.timesPerWeek,
    required this.duration,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      schedules,
      frequency,
      timesPerWeek,
      duration,
    ];
  }

  MedicationEntity copyWith({
    String? id,
    String? title,
    String? description,
    int? schedules,
    String? frequency,
    int? timesPerWeek,
    int? duration,
  }) {
    return MedicationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      schedules: schedules ?? this.schedules,
      frequency: frequency ?? this.frequency,
      timesPerWeek: timesPerWeek ?? this.timesPerWeek,
      duration: duration ?? this.duration,
    );
  }
}
