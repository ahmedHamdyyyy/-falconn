import 'package:falcon/core/core_exports.dart';

class DoctorModel extends DoctorEntity {
  DoctorModel({
    required super.id,
    required super.image,
    required super.imageUrl,
    required super.name,
    required super.phone,
    required super.description,
  });

  factory DoctorModel.fromJson(Map<String ,dynamic> json ,{required bool isMyLearning}) => DoctorModel(
        id          : isMyLearning? json["doctor_id"]                  :json["id"] ,
        name        : isMyLearning? json["doctor_name"]                :json["name"] ,
        image       : isMyLearning? json["doctor_image"]??""           :"" ,
        imageUrl    : isMyLearning? json["doctor_image_url"]??""       :json["image_url"] ??"",
        phone       : isMyLearning? json["doctor_phone"]??""           :json["phone"] ??"",
        description : isMyLearning? (json["doctor_description"]??"")   :json["description"] ??"",
      );
}
