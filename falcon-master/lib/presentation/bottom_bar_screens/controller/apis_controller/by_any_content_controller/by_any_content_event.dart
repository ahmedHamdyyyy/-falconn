part of 'by_any_content_bloc.dart';

@immutable
sealed class ByAnyContentEvent extends Equatable {}

class ByAnyContentEventRequestEvent extends ByAnyContentEvent {

  final String type;
  final String id;
  final String studentId;
  final String code;

  ByAnyContentEventRequestEvent({
    required this.type,
    required this.id,
    required this.studentId,
    required this.code,
  });

  @override
  List<Object> get props => [type, id, studentId, code];
}
