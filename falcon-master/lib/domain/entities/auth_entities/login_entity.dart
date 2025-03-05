import 'package:falcon/core/core_exports.dart';

class LoginEntity extends Equatable {

  final String message;
  final UserEntity user;

  LoginEntity({
    required this.message,
    required this.user,
  });

  @override
  List<Object> get props => [message, user];
}
