import 'package:falcon/core/core_exports.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentBloc() : super(AssignmentState(questions: _loadQuestions())) {
    on<LoadQuestions>((event, emit) {
      // Load initial questions if needed
    });

    on<AnswerQuestion>((event, emit) {
      final updatedAnswers = List<int?>.from(state.answers);
      updatedAnswers[event.questionIndex] = event.selectedAnswerIndex;

      emit(state.copyWith(answers: updatedAnswers));
    });
  }

  static List<QuestionAssignment> _loadQuestions() {
    // Flutter-related questions
    return [
      QuestionAssignment('9. Which widget is used for creating a scrollable list?', [
        'Container',
        'ListView',
        'Scaffold',
        'AppBar'
      ]),
      QuestionAssignment('2. Who created Flutter?', [
        'Facebook',
        'Apple',
        'Google',
        'Microsoft'
      ]),
      QuestionAssignment('3. What language is used to write Flutter apps?', [
        'JavaScript',
        'Python',
        'Java',
        'Dart'
      ]),
      QuestionAssignment('4. What is a widget in Flutter?', [
        'A graphical control element',
        'A backend service',
        'A database',
        'A type of API'
      ]),
      QuestionAssignment('5. Which of the following is a state management approach in Flutter?', [
        'MVC',
        'Redux',
        'GetX',
        'All of the above'
      ]),
      QuestionAssignment('6. What is the purpose of the pubspec.yaml file?', [
        'To define the app’s database configuration',
        'To list dependencies for the app',
        'To manage network requests',
        'To style the app’s widgets'
      ]),
      QuestionAssignment('7. How do you run a Flutter app?', [
        'flutter start',
        'flutter run',
        'flutter execute',
        'flutter build'
      ]),
      QuestionAssignment('8. What is the command to create a new Flutter project?', [
        'flutter new project',
        'flutter init',
        'flutter create',
        'flutter start new'
      ]),
      QuestionAssignment('10. What does the "hot reload" feature in Flutter do?', [
        'Rebuilds the app from scratch',
        'Saves the app’s state and injects code changes into the Dart Virtual Machine',
        'Clears the cache and reloads the app',
        'Updates the app’s backend server'
      ]),
      QuestionAssignment('1. What is Flutter?', [
        'A UI toolkit for building natively compiled applications for mobile, web, and desktop',
        'A programming language',
        'A database management tool',
        'An operating system'
      ]),
    ];
  }
}


class QuestionAssignment {
  final String text;
  final List<String> options;

  QuestionAssignment(this.text, this.options);
}
