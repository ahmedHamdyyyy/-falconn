import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class RateAndCommentUsecase extends BaseUseCase<RateEntity,RateAndCommentParameters>{

  final GeneralBaseRepo generalBaseRepo ;

  RateAndCommentUsecase({required this.generalBaseRepo});

  @override
  Future<Either<Failure, RateEntity>> call(RateAndCommentParameters parameters) async{
    return await generalBaseRepo.rateAndComment(parameters: parameters);
  }


}
class RateAndCommentParameters extends Equatable {
  final String studentId;
  final String subjectId;
  final String rate;
  final String comment;

  RateAndCommentParameters({
    required this.studentId,
    required this.subjectId,
    required this.rate,
    required this.comment,
  });

  @override
  List<Object> get props => [studentId, subjectId, rate, comment];
}
