import 'package:falcon/core/core_exports.dart';

class SubjectModel extends SubjectEntity {
  SubjectModel({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
    required super.imageUrl,
    required super.chapters,
    required super.doctors,
    required super.description,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json ,{required bool isMyLearning}) => SubjectModel(
    id        : isMyLearning? json["subject_id"]              :json["subject_id"],
    name      : isMyLearning? (json["subject_name"])          :json["subject_name"],
    image     : isMyLearning? (json["subject_image"]??"")     :"",
    imageUrl  : isMyLearning? (json["subject_image_url"]??"") :json["subject_image_url"]??"",
    chapters  : isMyLearning? List<ChapterModel>.from((json["chapters"] ).map((e)=>ChapterModel.fromJson(e,isMyLearning: isMyLearning)))   :[],
    doctors   : isMyLearning?  List<DoctorModel>.from((json["doctors"] ).map((e)=>DoctorModel.fromJson(e,isMyLearning: true)))   : List<DoctorModel>.from((json["doctors"] ).map((e)=>DoctorModel.fromJson(e,isMyLearning: false))),
    price      : isMyLearning? json["subject_price"]            : json["subject_price"],
    description: isMyLearning? (json["subject_description"]??"")      :( json["subject_description"]??""),
  );
}


