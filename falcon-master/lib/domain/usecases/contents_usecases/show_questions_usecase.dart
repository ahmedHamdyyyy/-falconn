import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ShowQuestionsUsecase extends BaseUseCase<QuizEntity,ShowQuestionsParameters>{

  final ContentsBaseRepo contentsBaseRepo ;

  ShowQuestionsUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure,QuizEntity>> call(ShowQuestionsParameters parameters) async{
    return await contentsBaseRepo.showQuestions(parameters: parameters);
  }


}

class ShowQuestionsParameters extends Equatable {
  final int quizId;

  ShowQuestionsParameters({required this.quizId});

  @override
  List<Object> get props => [quizId];
}