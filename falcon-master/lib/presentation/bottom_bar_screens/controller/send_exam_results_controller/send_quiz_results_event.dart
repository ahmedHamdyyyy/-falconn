part of 'send_quiz_results_bloc.dart';

abstract class SendQuizResultsEvent extends Equatable {
  const SendQuizResultsEvent();

  @override
  List<Object> get props => [];
}

class SendQuizResults extends SendQuizResultsEvent {
  final String studentId;
  final String quizId;
  final List<Map<String, dynamic>> answers;

  const SendQuizResults({
    required this.studentId,
    required this.quizId,
    required this.answers,
  });

  @override
  List<Object> get props => [studentId, quizId, answers];
}
