
import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_wallet_amount_event.dart';
part 'get_wallet_amount_state.dart';

class GetWalletAmountBloc extends Bloc<GetWalletAmountEvent, GetWalletAmountState> {

  final ShowWalletUsecase showWalletUsecase ;
  GetWalletAmountBloc({required this.showWalletUsecase}) : super(GetWalletAmountState()) {
    on<GetWalletAmountRequestEvent>(_getWalletAmountRequestEvent);
  }

  FutureOr<void> _getWalletAmountRequestEvent(GetWalletAmountRequestEvent event, Emitter<GetWalletAmountState> emit) async{
    final result = await showWalletUsecase(ShowWalletParameters(studentId: event.userId));

    result.fold(
        (l)=>emit(GetWalletAmountState(
          requestState: RequestState.error,
          responseMessage: l.message,
        )),

        (r)=>emit(GetWalletAmountState(
          walletEntity: r,
          requestState: RequestState.done,

        ))
    );
  }
}
