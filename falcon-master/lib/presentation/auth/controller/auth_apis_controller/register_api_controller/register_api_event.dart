part of 'register_api_bloc.dart';

@immutable
sealed class RegisterApiEvent extends Equatable {
  RegisterApiEvent();

  @override
  List<Object> get props => [];
}

class RegisterRequestEvent extends RegisterApiEvent {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String university;
  final String faculty;
  final String level;
  final String fcmtoken;
  RegisterRequestEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.university,
    required this.faculty,
    required this.level,
    required this.fcmtoken,
  });

  @override
  List<Object> get props => [
        name,
        phone,
        email,
        password,
        university,
        faculty,
        level,
        fcmtoken,
      ];
}
