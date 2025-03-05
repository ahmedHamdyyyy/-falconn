import 'package:falcon/core/core_exports.dart';

class RegisterEntity extends Equatable {

  final String message;
  final UserEntity user;

  RegisterEntity({
    required this.message,
    required this.user,
  });

  @override
  List<Object> get props => [message, user];
}
