part of 'get_student_modules_bloc.dart';

@immutable
sealed class GetStudentModulesEvent extends Equatable {}

class GetStudentModulesRequestEvent extends GetStudentModulesEvent {

  final int studentId;

  GetStudentModulesRequestEvent({required this.studentId});

  @override
  List<Object> get props => [studentId];
}
