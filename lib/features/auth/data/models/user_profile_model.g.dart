// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as String,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      medicalReportImg: json['medicalReportImg'] as String,
      gander: json['gander'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      location: json['location'] as String,
      fullName: json['fullName'] as String,
      diagnosis: json['diagnosis'] as String,
      stage: json['stage'] as String,
      profileImg: json['profileImg'] as String,
      role: json['role'] as String,
      medications: (json['medications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tasks: (json['tasks'] as List<dynamic>).map((e) => e as String).toList(),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'medicalReportImg': instance.medicalReportImg,
      'profileImg': instance.profileImg,
      'gander': instance.gander,
      'diagnosis': instance.diagnosis,
      'stage': instance.stage,
      'dateOfBirth': instance.dateOfBirth,
      'location': instance.location,
      'fullName': instance.fullName,
      'role': instance.role,
      'medications': instance.medications,
      'tasks': instance.tasks,
      'token': instance.token,
    };
