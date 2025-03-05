import 'package:falcon/core/core_exports.dart';
class AssignmentAnswerEntity extends Equatable {
  final String question;
  final String studentAnswer;
  final String correctAnswer;

  AssignmentAnswerEntity({
    required this.question,
    required this.studentAnswer,
    required this.correctAnswer,
  });

  @override
  List<Object> get props => [question, studentAnswer, correctAnswer];
}
