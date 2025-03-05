import 'package:falcon/core/core_exports.dart';

class LastChapterModel extends LastChapterEntity {
  LastChapterModel({
    required super.id,
    required super.img,
    required super.name,
    required super.course,
    required super.subjectName,
    required super.description,
  });

  factory LastChapterModel.fromJson(Map<String,dynamic> json) => LastChapterModel(
    id: json["id"],
    name: json["chapter_name"],
    course: json["course"],
    subjectName: json["subject_name"]??"",
    img: json["image_url"]??"",
    description: json["description"]??"",
  );
}
