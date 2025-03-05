import 'package:falcon/core/core_exports.dart';

class AnswerSentEntity extends Equatable {
  final String questionId;
  final String choiceNumber;

  AnswerSentEntity({
    required this.questionId,
    required this.choiceNumber,
  });

  @override
  List<Object> get props => [questionId, choiceNumber];
}
