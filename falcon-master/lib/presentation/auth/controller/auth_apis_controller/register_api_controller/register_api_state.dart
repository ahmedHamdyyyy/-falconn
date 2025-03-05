part of 'register_api_bloc.dart';


sealed class RegisterApiState extends Equatable {}

class RegisterApiInitial extends RegisterApiState {
  @override
  List<Object> get props => [];
}

class RegisterApiRequestState extends RegisterApiState {

  final RegisterEntity? registerResponse;
  final RequestState requestState;
  final String RegisterMessage;

  RegisterApiRequestState({
    this.registerResponse,
    this.requestState = RequestState.loading,
    this.RegisterMessage = "",
  });

  @override
  List<Object?> get props => [registerResponse, requestState, RegisterMessage];
}

