part of 'get_questions_bloc.dart';

@immutable
sealed class GetQuestionsEvent extends Equatable {}

class GetQuestionsRequestEvent extends GetQuestionsEvent {

  final int quizId;
  GetQuestionsRequestEvent({required this.quizId});

  @override
  List<Object> get props => [quizId];
}
