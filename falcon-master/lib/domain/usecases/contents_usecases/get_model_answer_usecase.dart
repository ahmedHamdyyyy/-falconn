import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class GetModelAnswerUsecase extends BaseUseCase<List<AnswerCorrectEntity>,GetModelAnswersParameters>{


  final ContentsBaseRepo contentsBaseRepo ;

  GetModelAnswerUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure, List<AnswerCorrectEntity>>> call(GetModelAnswersParameters parameters) async{
    return await contentsBaseRepo.getModelAnswers(parameters: parameters);
  }


}

class GetModelAnswersParameters extends Equatable {

  final String studentId;
  final String quizId;

  GetModelAnswersParameters({required this.studentId,required this.quizId});

  @override
  List<Object> get props => [studentId, quizId];


}