// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class TimeZoneEntity extends Equatable {
  final String timeZoneId;
  final String timeZoneName;

  const TimeZoneEntity({
    required this.timeZoneId,
    required this.timeZoneName,
  });

  @override
  List<Object> get props => [timeZoneId, timeZoneName];
}
