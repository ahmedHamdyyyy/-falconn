import 'package:falcon/core/core_exports.dart';

class WalletEntity extends Equatable {

  final String message;
  final StudentEntity student;
  final String totalMoney;

  WalletEntity({
    required this.message,
    required this.student,
    required this.totalMoney,
  });

  @override
  List<Object> get props => [message, student, totalMoney];
}
