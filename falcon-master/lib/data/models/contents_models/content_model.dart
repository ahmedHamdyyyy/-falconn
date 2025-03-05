import 'package:falcon/core/core_exports.dart';

class ContentModel extends ContentEntity {
  ContentModel({
    required super.id,
    required super.type,
    required super.name,
    required super.timer,
    required super.enddate,
    required super.iframe,
    required super.file,
    required super.numberOfQuestions,
    required super.completed,
  });

  factory ContentModel.fromJson(Map<String ,dynamic> json){
    return ContentModel(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      iframe: json["iframe"],
      file: json["file"],
      timer: json["timer"],
      enddate: json["enddate"],
      numberOfQuestions: json["number_of_questions"],
      completed: json["completed"],
    );
  }
}
