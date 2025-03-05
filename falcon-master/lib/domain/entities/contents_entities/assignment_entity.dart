import 'package:falcon/core/core_exports.dart';

class AssignmentEntity extends Equatable {

  final String subjectName;
  final String homeworkName;
  final List<QuestionEntity> questions;

  AssignmentEntity({
    required this.subjectName,
    required this.homeworkName,
    required this.questions,
  });

  @override
  List<Object> get props => [subjectName, homeworkName, questions];
}


