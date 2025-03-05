import 'package:falcon/core/core_exports.dart';

class UserEntity extends Equatable {

  final String id;
  final String name;
  final String phone;
  final String email;
  final String? university;
  final String? faculty;
  final String? level;
  final String? fcmToken;
  final String? deviceId;

  UserEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.university,
    required this.faculty,
    required this.level,
    required this.fcmToken,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [id, name, email, phone, university, faculty, level,fcmToken,deviceId];
}
