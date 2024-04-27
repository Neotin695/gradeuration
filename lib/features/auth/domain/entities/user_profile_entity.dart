// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String userName;
  final String phoneNumber;
  final String email;
  final String password;
  final String medicalReportImg;
  final String profileImg;
  final String gander;
  final String diagnosis;
  final String stage;
  final String dateOfBirth;
  final String location;
  final String fullName;
  final String role;
  final List<String> medications;

  const UserProfileEntity({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.medicalReportImg,
    required this.profileImg,
    required this.gander,
    required this.diagnosis,
    required this.stage,
    required this.dateOfBirth,
    required this.location,
    required this.fullName,
    required this.role,
    required this.medications,
  });

  @override
  List<Object> get props {
    return [
      id,
      userName,
      phoneNumber,
      email,
      password,
      medicalReportImg,
      profileImg,
      gander,
      diagnosis,
      stage,
      dateOfBirth,
      location,
      fullName,
      role,
    ];
  }

 

  UserProfileEntity copyWith({
    String? id,
    String? userName,
    String? phoneNumber,
    String? email,
    String? password,
    String? medicalReportImg,
    String? profileImg,
    String? gander,
    String? diagnosis,
    String? stage,
    String? dateOfBirth,
    String? location,
    String? fullName,
    String? role,
    List<String>? medications,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      medicalReportImg: medicalReportImg ?? this.medicalReportImg,
      profileImg: profileImg ?? this.profileImg,
      gander: gander ?? this.gander,
      diagnosis: diagnosis ?? this.diagnosis,
      stage: stage ?? this.stage,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      medications: medications ?? this.medications,
    );
  }
}
