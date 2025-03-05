part of 'rate_and_comment_bloc.dart';

@immutable
sealed class RateAndCommentEvent extends Equatable {}

class RateAndCommentRequestEvent extends RateAndCommentEvent {

  final String studentId;
  final String subjectId;
  final String ratingValue;
  final String comment;

  RateAndCommentRequestEvent({
    required this.studentId,
    required this.subjectId,
    required this.ratingValue,
    required this.comment,
  });

  @override
  List<Object> get props => [
        studentId,
        subjectId,
        ratingValue,
        comment,
      ];
}
