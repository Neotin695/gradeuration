// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MedicationEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String cause;
  final String frequency;
  final int timesPerWeek;
  final int pill;
  final String type;
  final int duration;
  final int taken;
  final List<String> schedules;
  const MedicationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.cause,
    required this.frequency,
    required this.timesPerWeek,
    required this.pill,
    required this.type,
    required this.duration,
    required this.taken,
    required this.schedules,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      cause,
      frequency,
      timesPerWeek,
      pill,
      type,
      duration,
      taken,
      schedules,
    ];
  }

  MedicationEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? cause,
    String? frequency,
    int? timesPerWeek,
    int? pill,
    String? type,
    int? duration,
    int? taken,
    List<String>? schedules,
  }) {
    return MedicationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      cause: cause ?? this.cause,
      frequency: frequency ?? this.frequency,
      timesPerWeek: timesPerWeek ?? this.timesPerWeek,
      pill: pill ?? this.pill,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      taken: taken ?? this.taken,
      schedules: schedules ?? this.schedules,
    );
  }
}
