part of 'validate_code_charge_bloc.dart';

sealed class ValidateCodeChargeState extends Equatable {}

class ValidateCodeChargeInitial extends ValidateCodeChargeState {
  @override
  List<Object> get props => [];
}
class ValidateCodeChargeRequestState extends ValidateCodeChargeState {

  final ChargeCodeEntity? chargeResponse;
  final RequestState requestState;
  final String responseMessage;

  ValidateCodeChargeRequestState({
    this.chargeResponse,
    this.requestState = RequestState.loading,
    this.responseMessage = "",
  });

  @override
  List<Object?> get props => [
        chargeResponse,
        requestState,
        responseMessage,
      ];
}
