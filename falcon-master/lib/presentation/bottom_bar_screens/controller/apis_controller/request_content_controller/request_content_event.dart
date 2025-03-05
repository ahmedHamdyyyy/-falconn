part of 'request_content_bloc.dart';

@immutable
sealed class RequestContentEvent extends Equatable {}

class RequestContentEventRequestEvent extends RequestContentEvent {

  final String type;
  final String id;
  final String studentId;

  RequestContentEventRequestEvent({
    required this.type,
    required this.id,
    required this.studentId,
  });

  @override
  List<Object> get props => [type, id, studentId];
}
