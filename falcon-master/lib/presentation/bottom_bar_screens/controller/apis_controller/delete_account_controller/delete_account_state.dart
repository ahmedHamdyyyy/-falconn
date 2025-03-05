part of 'delete_account_bloc.dart';


@immutable
class DeleteAccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteAccountInitialState extends DeleteAccountState {}

class DeleteAccountRequestState extends DeleteAccountState {
  final String deleteAccountResponse;
  final RequestState requestState;
  final String responseMessage;

  DeleteAccountRequestState({
    this.deleteAccountResponse = '',
    this.requestState = RequestState.loading,
    this.responseMessage = "",
  });

  @override
  List<Object> get props =>
      [
        deleteAccountResponse,
        requestState,
        responseMessage,
      ];
}