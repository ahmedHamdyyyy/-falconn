part of 'validate_code_charge_bloc.dart';

@immutable
sealed class ValidateCodeChargeEvent extends Equatable {}

class ValidateCodeChargeRequestEvent extends ValidateCodeChargeEvent {

  final int studentId;
  final String code;

  ValidateCodeChargeRequestEvent({
    required this.studentId,
    required this.code,
  });

  @override
  List<Object> get props => [studentId, code];
}
