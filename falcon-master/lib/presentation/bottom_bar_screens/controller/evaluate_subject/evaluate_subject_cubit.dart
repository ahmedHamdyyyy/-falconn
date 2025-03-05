
import 'package:falcon/core/core_exports.dart';

// Rating State
class EvaluateSubjectState extends Equatable {
  final double rating;
  final String comment;

  const EvaluateSubjectState({this.rating = 0, this.comment = ''});

  EvaluateSubjectState copyWith({double? rating, String? comment}) {
    return EvaluateSubjectState(
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [rating, comment];
}

// Rating Cubit
class EvaluateSubjectCubit extends Cubit<EvaluateSubjectState> {
  EvaluateSubjectCubit() : super(const EvaluateSubjectState());

  void updateRating(double rating) {
    emit(state.copyWith(rating: rating));
  }

  void updateComment(String comment) {
    emit(state.copyWith(comment: comment));
  }

  void submitEvaluation({required String subjectId ,required BuildContext context}) {
    context.read<RateAndCommentBloc>()..add(RateAndCommentRequestEvent(
        studentId: context.read<CurrentUserBloc>().userData!.id,
        subjectId: subjectId, ratingValue: state.rating.toString(), comment: state.comment));
  }
}