import 'dart:async';

import 'package:falcon/core/core_exports.dart';
part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {

  DeleteAccountUsecase deleteAccountUsecase;
  DeleteAccountBloc({required this.deleteAccountUsecase}) : super(DeleteAccountInitialState()) {
    on<DeleteAccountResponseEvent>(_DeleteAccountRequest);
  }

  FutureOr<void> _DeleteAccountRequest(DeleteAccountResponseEvent event, Emitter<DeleteAccountState> emit) async{

    emit(DeleteAccountRequestState(requestState: RequestState.loading));

    final result = await deleteAccountUsecase(DeleteAccountParameters(studentId: event.studentId));

    result.fold(
            (l)=>emit(DeleteAccountRequestState(
          requestState: RequestState.error,
          responseMessage: l.message,
        )),

            (r)=>emit(DeleteAccountRequestState(
          deleteAccountResponse: r,
          requestState: RequestState.done,
        ))
    );

    print("from bloc : $state");
  }
}
