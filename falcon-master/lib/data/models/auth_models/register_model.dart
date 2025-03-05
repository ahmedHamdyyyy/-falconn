import 'package:falcon/core/core_exports.dart';

class RegisterModel extends RegisterEntity {

  RegisterModel({
    required super.message,
    required super.user,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json["message"],
    user: UserModel.fromJson(json["user"],authIsLogin: false),
  );

}