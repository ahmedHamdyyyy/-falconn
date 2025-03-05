import 'package:falcon/core/core_exports.dart';

class WalletModel extends WalletEntity {
  WalletModel({
    required super.message,
    required super.student,
    required super.totalMoney,
  });

  factory WalletModel.fromJson(Map<String,dynamic> json) => WalletModel(
    message: json["message"],
    student: StudentModel.fromJson(json["student"]),
    totalMoney: json["total_money"].toString(),

  );
}
