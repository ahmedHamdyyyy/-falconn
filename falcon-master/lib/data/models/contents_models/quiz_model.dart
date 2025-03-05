import 'package:falcon/core/core_exports.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required super.subjectName,
    required super.examName,
    required super.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    subjectName: json["subject_name"],
    examName: json["exam_name"],
    questions: List<QuestionModel>.from(json["questions"].map((e)=>QuestionModel.fromJson(e))),
  );
}
