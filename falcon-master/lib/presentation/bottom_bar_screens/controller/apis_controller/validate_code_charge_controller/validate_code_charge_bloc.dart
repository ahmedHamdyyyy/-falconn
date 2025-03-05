
import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'validate_code_charge_event.dart';
part 'validate_code_charge_state.dart';

class ValidateCodeChargeBloc extends Bloc<ValidateCodeChargeEvent, ValidateCodeChargeState> {

  final ValidateCodeAndChargeUsecase validateCodeChargeUsecase;
  ValidateCodeChargeBloc({required this.validateCodeChargeUsecase}) : super(ValidateCodeChargeInitial()) {
    on<ValidateCodeChargeRequestEvent>(_ValidateCodeChargeRequest);
  }

  FutureOr<void> _ValidateCodeChargeRequest(ValidateCodeChargeRequestEvent event, Emitter<ValidateCodeChargeState> emit) async{
    final result = await validateCodeChargeUsecase(ValidateCodeAndChargeParameters(
        studentId: event.studentId,
         code: event.code,
    ));



    result.fold(
       (l)=>emit(ValidateCodeChargeRequestState(
          requestState: RequestState.error,
          responseMessage: l.message,
        )),

       (r)=>emit(ValidateCodeChargeRequestState(
          chargeResponse: r,
          requestState: RequestState.done,
        ))
    );
  }
}
