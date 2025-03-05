import 'package:falcon/core/core_exports.dart';

class ChargeCodeModel extends ChargeCodeEntity {
  ChargeCodeModel({
    required super.success,
    required super.newBalance,
  });

  factory ChargeCodeModel.fromJson(Map<String,dynamic> json) => ChargeCodeModel(
        success: json["success"],
        newBalance: json["newBalance"],
      );
}
