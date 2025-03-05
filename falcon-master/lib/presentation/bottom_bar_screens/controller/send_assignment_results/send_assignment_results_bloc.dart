

import 'package:falcon/core/core_exports.dart';

part 'send_assignment_results_event.dart';
part 'send_assignment_results_state.dart';

class SendAssignmentResultsBloc extends Bloc<SendAssignmentResultsEvent, SendAssignmentResultsState> {
  final Dio _dio;

  SendAssignmentResultsBloc(this._dio) : super(SendAssignmentResultsInitial()) {
    on<SendAssignmentResults>(_onSendAssignmentResults);
  }

  Future<void> _onSendAssignmentResults(SendAssignmentResults event, Emitter<SendAssignmentResultsState> emit) async {
    emit(SendAssignmentResultsLoading());
    try {
      final response = await _dio.post(
        'https://optima-software-solutions.com/falcon/gethomeworkresults.php',
        data: {
          'studentid': event.studentId,
          'assignmentid': event.assignmentId,
          'answers': event.answers.map((answer) => {
            'questionid': answer['questionid'],
            'choice': answer['choice'],
          }).toList(),
        },
      );

      if (response.data['success'] != null) {
        emit(SendAssignmentResultsSuccess(response.data['success']));
      } else if (response.data['error'] != null) {
        emit(SendAssignmentResultsError(response.data['error']));
      }
    } catch (e) {
      emit(SendAssignmentResultsError('An error occurred while submitting the results.'));
    }
  }
}