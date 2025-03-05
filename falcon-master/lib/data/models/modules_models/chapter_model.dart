import 'package:falcon/core/core_exports.dart';

class ChapterModel extends ChapterEntity {
  ChapterModel({
    required super.id,
    required super.name,
    required super.img,
    required super.imgUrl,
    required super.course,
    required super.subjectId,
    required super.description,
  });

  factory ChapterModel.fromJson(Map<String,dynamic> json ,{required bool isMyLearning}) => ChapterModel(
    id          : isMyLearning? json["chapter_id"]              :json["id"],
    name        : isMyLearning? (json["chapter_name"])          :json["name"],
    img         : isMyLearning? (json["chapter_image"]??"")     :"",
    imgUrl      : isMyLearning? (json["chapter_image_url"]??"") :json["image_url"]??"",
    subjectId   : isMyLearning? ""                              :json["subjectid"],
    course      : isMyLearning? ""                              :json["course"],
    description : isMyLearning? ( json["chapter_description"]??"")     :( json["description"]??""),

  );
}
