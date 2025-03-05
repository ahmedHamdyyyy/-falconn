import 'package:falcon/core/core_exports.dart';

class StudentEntity extends Equatable {

  final String id;
  final String username;
  final String email;

  StudentEntity({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  List<Object> get props => [];
}
