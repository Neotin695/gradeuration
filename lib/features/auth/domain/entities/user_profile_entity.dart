// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String userName;
  final String phoneNumber;
  final String email;
  final String password;
  final String imageUrl;
  final String gander;
  final String diagnosis;
  final String stage;
  final String dateOfBirth;
  final String location;
  final String fullName;

  const UserProfileEntity({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.imageUrl,
    required this.gander,
    required this.diagnosis,
    required this.stage,
    required this.dateOfBirth,
    required this.location,
    required this.fullName,
  });

  @override
  List<Object> get props {
    return [
      id,
      userName,
      phoneNumber,
      email,
      password,
      imageUrl,
      gander,
      dateOfBirth,
      location,
      fullName,
    ];
  }



  UserProfileEntity copyWith({
    String? id,
    String? userName,
    String? phoneNumber,
    String? email,
    String? password,
    String? imageUrl,
    String? gander,
    String? diagnosis,
    String? stage,
    String? dateOfBirth,
    String? location,
    String? fullName,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      gander: gander ?? this.gander,
      diagnosis: diagnosis ?? this.diagnosis,
      stage: stage ?? this.stage,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      fullName: fullName ?? this.fullName,
    );
  }
}
