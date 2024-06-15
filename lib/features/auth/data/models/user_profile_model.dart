import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_profile_entity.dart';
part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    required super.userName,
    required super.phoneNumber,
    required super.email,
    required super.password,
    required super.medicalReportImg,
    required super.gander,
    required super.dateOfBirth,
    required super.location,
    required super.fullName,
    required super.diagnosis,
    required super.stage,
    required super.profileImg,
    required super.role,
    required super.medications,
    required super.tasks,
    required super.token,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  factory UserProfileModel.fromEntity(UserProfileEntity entity) =>
      UserProfileModel(
        id: entity.id,
        userName: entity.userName,
        phoneNumber: entity.phoneNumber,
        email: entity.email,
        password: entity.password,
        medicalReportImg: entity.medicalReportImg,
        gander: entity.gander,
        dateOfBirth: entity.dateOfBirth,
        location: entity.location,
        fullName: entity.fullName,
        diagnosis: entity.diagnosis,
        stage: entity.stage,
        profileImg: entity.profileImg,
        role: entity.role,
        medications: entity.medications,
        tasks: entity.tasks,
        token: entity.token,
      );
}
