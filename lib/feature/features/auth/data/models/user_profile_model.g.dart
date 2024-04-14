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
      imageUrl: json['imageUrl'] as String,
      gander: json['gander'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      location: json['location'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'imageUrl': instance.imageUrl,
      'gander': instance.gander,
      'dateOfBirth': instance.dateOfBirth,
      'location': instance.location,
      'fullName': instance.fullName,
    };
