import 'package:flutter/material.dart';
import 'package:gradeuration/core/tools/tools.dart';

List<Map<String, dynamic>> gendar = [
  {'id': 'male', 'value': t.male},
  {'id': 'female', 'value': t.female},
];
List<Map<String, dynamic>> diagnosis = [
  {'id': 'anemia', 'value': t.anemia},
  {'id': 'diabetes', 'value': t.diabetes},
  {'id': 'stroke', 'value': t.stroke},
  {'id': 'seizures', 'value': t.seizures},
  {'id': 'backInjury', 'value': t.backInjury},
];
List<Map<String, dynamic>> stage = [
  {'id': 'little', 'value': t.little},
  {'id': 'medium', 'value': t.medium},
  {'id': 'malignant', 'value': t.malignant},
];

Map<String, int> daysMap = {
  'Monday': DateTime.monday,
  'Tuesday': DateTime.tuesday,
  'Wednesday': DateTime.wednesday,
  'Thursday': DateTime.thursday,
  'Friday': DateTime.friday,
  'Saturday': DateTime.saturday,
  'Sunday': DateTime.sunday,
};

enum Frequency {
  daily,
  weekly,
}

enum DurationMedication {
  month(count: 30),
  month2(count: 60),
  month3(count: 90),
  day1(count: 1),
  day2(count: 2),
  day3(count: 3),
  week(count: 7),
  week2(count: 14),
  week3(count: 12),
  permanent(count: 999999999);

  const DurationMedication({required this.count});
  final int count;
}

const String baseUrlSendNotification = 'https://fcm.googleapis.com';

List<String> schedule = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

List<Color> colorsSchedule = [
  Colors.green[300]!,
  Colors.pink[300]!,
  Colors.blue[300]!
];

enum Amount {
  pill,
  dose;
}
