import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class GetAssignmentAnswerUsecase extends BaseUseCase<List<AssignmentAnswerEntity>,GetAssignmentModelAnswersParameters>{


  final ContentsBaseRepo contentsBaseRepo ;

  GetAssignmentAnswerUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure, List<AssignmentAnswerEntity>>> call(GetAssignmentModelAnswersParameters parameters) async{
    return await contentsBaseRepo.getAssignmentModelAnswers(parameters: parameters);
  }


}

class GetAssignmentModelAnswersParameters extends Equatable {

  final String studentId;
  final String quizId;

  GetAssignmentModelAnswersParameters({required this.studentId,required this.quizId});

  @override
  List<Object> get props => [studentId, quizId];


}