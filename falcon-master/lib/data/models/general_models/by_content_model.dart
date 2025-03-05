import 'package:falcon/core/core_exports.dart';

class ByContentModel extends ByContentEntity {
  ByContentModel({required super.success});

  factory ByContentModel.fromJson(Map<String,dynamic> json) => ByContentModel(
    success: json["success"],
  );

}