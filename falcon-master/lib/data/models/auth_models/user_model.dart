import 'package:falcon/core/core_exports.dart';

class UserModel extends UserEntity {

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.university,
    required super.faculty,
    required super.level,
    required super.fcmToken,
    required super.deviceId,
  });


  factory UserModel.fromJson(Map<String, dynamic> json,{required bool authIsLogin}) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    deviceId: json["deviceid"],
    fcmToken:json["fcmtoken"],
    university:authIsLogin?json["university_name"]:json["university"],
    faculty: authIsLogin?json["college_name"]:json["faculty"],
    level: authIsLogin?json["level_name"]:json["level"],

  );

}