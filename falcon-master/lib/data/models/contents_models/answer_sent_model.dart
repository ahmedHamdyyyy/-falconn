import 'package:falcon/core/core_exports.dart';

class AnswerSentModel extends AnswerSentEntity {
  AnswerSentModel({
    required super.questionId,
    required super.choiceNumber,
  });


factory AnswerSentModel.fromJson(Map<String, dynamic> json) =>AnswerSentModel(
    questionId: json["questionId"],
    choiceNumber: json["questionId"],
);

}