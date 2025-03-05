import 'package:falcon/core/core_exports.dart';

class AnswerCorrectModel extends AnswerCorrectEntity {
  AnswerCorrectModel({
    required super.question,
    required super.studentAnswer,
    required super.correctAnswer,
  });

  factory AnswerCorrectModel.fromJson(Map<String, dynamic> json) => AnswerCorrectModel(
        question: json["question"],
        studentAnswer: json["student_answer"],
        correctAnswer: json["correct_answer"],
      );
}

