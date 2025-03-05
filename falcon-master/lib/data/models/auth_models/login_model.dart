import 'package:falcon/core/core_exports.dart';

class LoginModel extends LoginEntity {

  LoginModel({
    required super.message,
    required super.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"],
    user: UserModel.fromJson(json["user"],authIsLogin: true),
  );

}