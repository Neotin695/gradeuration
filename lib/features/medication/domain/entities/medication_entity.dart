// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MedicationEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String whoAdded;
  final String userId;
  final String doctorId;
  final String cause;
  final String doseType;
  final String frequencyType;
  final int totalDoses;
  final int dosesPerTimes;
  final int duration;
  final int timesPerDay;
  final List<Map<String, dynamic>> takeHistory;
  final List<String> daysOfWeek;
  const MedicationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.whoAdded,
    required this.userId,
    required this.doctorId,
    required this.cause,
    required this.doseType,
    required this.frequencyType,
    required this.totalDoses,
    required this.dosesPerTimes,
    required this.duration,
    required this.timesPerDay,
    required this.takeHistory,
    required this.daysOfWeek,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      whoAdded,
      userId,
      doctorId,
      cause,
      doseType,
      frequencyType,
      totalDoses,
      dosesPerTimes,
      duration,
      timesPerDay,
      takeHistory,
      daysOfWeek,
    ];
  }

  MedicationEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? whoAdded,
    String? userId,
    String? doctorId,
    String? cause,
    String? doseType,
    String? frequencyType,
    int? totalDoses,
    int? dosesPerTimes,
    int? duration,
    int? timesPerDay,
    List<Map<String, dynamic>>? takeHistory,
    List<String>? daysOfWeek,
  }) {
    return MedicationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      whoAdded: whoAdded ?? this.whoAdded,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      cause: cause ?? this.cause,
      doseType: doseType ?? this.doseType,
      frequencyType: frequencyType ?? this.frequencyType,
      totalDoses: totalDoses ?? this.totalDoses,
      dosesPerTimes: dosesPerTimes ?? this.dosesPerTimes,
      duration: duration ?? this.duration,
      timesPerDay: timesPerDay ?? this.timesPerDay,
      takeHistory: takeHistory ?? this.takeHistory,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }
}
