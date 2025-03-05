part of 'get_wallet_amount_bloc.dart';

@immutable
sealed class GetWalletAmountEvent extends Equatable{}

 class GetWalletAmountRequestEvent extends GetWalletAmountEvent {
  final int userId;

  GetWalletAmountRequestEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

