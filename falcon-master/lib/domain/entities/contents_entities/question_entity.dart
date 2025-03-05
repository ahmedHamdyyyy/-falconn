import 'package:falcon/core/core_exports.dart';

class QuestionEntity extends Equatable {
  final String questionId;
  final String question;
  final OptionModel options;

  QuestionEntity({
    required this.questionId,
    required this.question,
    required this.options,
  });

  @override
  List<Object> get props => [questionId, question, options];
}
