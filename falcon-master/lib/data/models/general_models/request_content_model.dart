import 'package:falcon/core/core_exports.dart';


class RequestContentModel extends RequestContentEntity {
  RequestContentModel({required super.message});

  factory RequestContentModel.fromJson(Map<String,dynamic> json) => RequestContentModel(
    message: json["message"],
  );

}