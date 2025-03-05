import 'package:falcon/core/core_exports.dart';

class StudentModel extends StudentEntity {
  StudentModel({
    required super.id,
    required super.username,
    required super.email,
  });

  factory StudentModel.fromJson(Map<String,dynamic> json) => StudentModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
  );
}
