import 'package:falcon/core/core_exports.dart';

class ProfileEntity extends Equatable {
  final String success;
  final StudentEditProfile ;

  ProfileEntity({
    required this.success,
    required this.StudentEditProfile,

  });

  @override
  List<Object> get props =>
      [
        success,
        StudentEditProfile
      ];
}

class StudentEditProfileEntity extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String university;
  final String faculty;
  final String level;
  final String fcmtoken;

  StudentEditProfileEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.university,
    required this.faculty,
    required this.level,
    required this.fcmtoken,
  });

  @override
  List<Object> get props =>
      [id, name, phone, email, university, faculty, level,fcmtoken];
}
