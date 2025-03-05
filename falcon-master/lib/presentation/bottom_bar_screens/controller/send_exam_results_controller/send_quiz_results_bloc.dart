import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'send_quiz_results_event.dart';
part 'send_quiz_results_state.dart';

class SendQuizResultsBloc extends Bloc<SendQuizResultsEvent, SendQuizResultsState> {
  final Dio _dio;

  SendQuizResultsBloc(this._dio) : super(SendQuizResultsInitial()) {
    on<SendQuizResults>(_onSendQuizResults);
  }

  Future<void> _onSendQuizResults(SendQuizResults event, Emitter<SendQuizResultsState> emit) async {
    emit(SendQuizResultsLoading());
    try {
      final response = await _dio.post(
        'https://optima-software-solutions.com/falcon/getexamresults.php',
        data: {
          'studentid': event.studentId,
          'quizid': event.quizId,
          'answers': event.answers.map((answer) => {
            'questionid': answer['questionid'],
            'choice': answer['choice'],
          }).toList(),
        },
      );

      if (response.data['success'] != null) {
        emit(SendQuizResultsSuccess(response.data['success']));
      } else if (response.data['error'] != null) {
        emit(SendQuizResultsError(response.data['error']));
      }
    } catch (e) {
      emit(SendQuizResultsError('An error occurred while submitting the results.'));
    }
  }
}
