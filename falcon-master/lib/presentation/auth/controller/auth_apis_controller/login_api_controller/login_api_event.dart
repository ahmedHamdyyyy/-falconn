part of 'login_api_bloc.dart';

@immutable
sealed class LoginApiEvent extends Equatable {
  LoginApiEvent();
}


class LoginRequestEvent extends LoginApiEvent {

  final String email;
  final String password;
  final GlobalKey<FormState> loginFormKey;

  LoginRequestEvent({
    required this.email,
    required this.password,
    required this.loginFormKey,
  });

  @override
  List<Object> get props => [email, password , loginFormKey];
}
