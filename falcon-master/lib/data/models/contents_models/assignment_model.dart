import 'package:falcon/core/core_exports.dart';

class AssignmentModel extends AssignmentEntity {
  AssignmentModel(
      {required super.subjectName,
      required super.homeworkName,
      required super.questions
      });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) => AssignmentModel(
    subjectName: json["subject_name"],
    homeworkName: json["homework_name"],
    questions: List<QuestionModel>.from(json["questions"].map((e)=>QuestionModel.fromJson(e))),
  );

}
