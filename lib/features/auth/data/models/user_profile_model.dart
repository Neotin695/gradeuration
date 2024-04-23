import 'package:gradeuration/features/auth/domain/entities/user_profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    required super.userName,
    required super.phoneNumber,
    required super.email,
    required super.password,
    required super.imageUrl,
    required super.gander,
    required super.dateOfBirth,
    required super.location,
    required super.fullName,
    required super.diagnosis,
    required super.stage,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
