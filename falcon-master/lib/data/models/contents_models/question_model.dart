import 'package:falcon/core/core_exports.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({
    required super.questionId,
    required super.question,
    required super.options,
  });


  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        questionId: json["questionid"],
        question: json["question"],
        options: OptionModel.fromJson(json["options"]),
      );
}
