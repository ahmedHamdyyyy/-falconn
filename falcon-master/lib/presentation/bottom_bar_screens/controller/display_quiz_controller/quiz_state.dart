part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoaded extends QuizState {
  final int currentIndex;
  final List<String?> selectedAnswers;
  final bool allQuestionsAnswered;

  const QuizLoaded(
      this.currentIndex,
      this.selectedAnswers,
      this.allQuestionsAnswered,
      );

  @override
  List<Object?> get props => [currentIndex, selectedAnswers, allQuestionsAnswered];
}
