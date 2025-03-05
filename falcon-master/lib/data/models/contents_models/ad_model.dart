import 'package:falcon/core/core_exports.dart';

class AdModel extends AdEntity {
  AdModel({
   required super.id,
   required super.video,
  });

  factory AdModel.fromJson(Map<String,dynamic> json) => AdModel(
    id:json["id"],
    video:json["video"]
  );

}
