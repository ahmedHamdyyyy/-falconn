import 'package:falcon/core/core_exports.dart';

class QuizEntity extends Equatable {
  final String subjectName;
  final String examName;
  final List<QuestionEntity> questions;

  QuizEntity({
    required this.subjectName,
    required this.examName,
    required this.questions,
  });

  @override
  List<Object> get props => [subjectName, examName, questions];
}
