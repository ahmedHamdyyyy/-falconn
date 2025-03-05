import 'package:falcon/core/core_exports.dart';
class AssignmentAnswerModel extends AssignmentAnswerEntity {
  AssignmentAnswerModel({
    required super.question,
    required super.studentAnswer,
    required super.correctAnswer,
  });

  factory AssignmentAnswerModel.fromJson(Map<String, dynamic> json) => AssignmentAnswerModel(
    question: json["Question"],
    studentAnswer: json["Student Answer"],
    correctAnswer: json["Correct Answer"],
  );
}

