import 'package:falcon/core/core_exports.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.success,
    required super.StudentEditProfile,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["message"],
    StudentEditProfile: StudentEditProfileModel.fromJson(json["student"]),
      );
}

class StudentEditProfileModel extends StudentEditProfileEntity {
  StudentEditProfileModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.university,
    required super.faculty,
    required super.level,
    required super.fcmtoken,
  });

  factory StudentEditProfileModel.fromJson(Map<String, dynamic> json) =>
      StudentEditProfileModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        level: json["level"],
        university: json["university"],
        faculty: json["faculty"],
        fcmtoken: json["fcmtoken"],
      );
}
