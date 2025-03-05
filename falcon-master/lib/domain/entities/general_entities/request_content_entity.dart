import 'package:falcon/core/core_exports.dart';

class RequestContentEntity extends Equatable{
  final String message;

  RequestContentEntity({required this.message});

  @override
  List<Object> get props => [message];
}