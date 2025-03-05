import 'package:falcon/core/core_exports.dart';

class ByContentEntity extends Equatable {

  final String success;

  ByContentEntity({required this.success});

  @override
  List<Object> get props => [success];
}