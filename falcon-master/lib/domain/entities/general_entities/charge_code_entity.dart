import 'package:falcon/core/core_exports.dart';

class ChargeCodeEntity extends Equatable {
  final String success;
  final double? newBalance;

  ChargeCodeEntity({
    required this.success,
    required this.newBalance,
  });

  @override
  List<Object?> get props => [success, newBalance];
}
