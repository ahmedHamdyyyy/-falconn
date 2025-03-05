part of 'login_api_bloc.dart';

sealed class LoginApiState extends Equatable {
}

class LoginApiInitial extends LoginApiState {
  @override
  List<Object> get props => [];
}

class LoginApiRequestState extends LoginApiState {

  final LoginEntity? loginResponse;
  final RequestState requestState;
  final String loginMessage;

  LoginApiRequestState({
    this.loginResponse,
    this.requestState = RequestState.loading,
    this.loginMessage = "",
  });

  @override
  List<Object?> get props => [loginResponse, requestState, loginMessage];
}

