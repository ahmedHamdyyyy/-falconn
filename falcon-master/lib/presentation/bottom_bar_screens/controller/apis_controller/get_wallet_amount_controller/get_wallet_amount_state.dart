part of 'get_wallet_amount_bloc.dart';


class GetWalletAmountState extends Equatable {
  final WalletEntity? walletEntity;
  final RequestState requestState;
  final String responseMessage;

  GetWalletAmountState({
    this.walletEntity,
    this.requestState = RequestState.loading,
    this.responseMessage = "",
  });

  @override
  List<Object?> get props => [
    walletEntity,
    requestState,
    responseMessage,
  ];
}
