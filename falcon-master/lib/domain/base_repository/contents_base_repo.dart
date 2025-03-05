import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

abstract class ContentsBaseRepo {

  Future<Either<Failure,List<AdEntity>>> getAds();
  Future<Either<Failure,List<ContentEntity>>> showAllContents({required ShowAllContentsParameters parameters});
  Future<Either<Failure,OrgContentsEntity>> showOrgContents({required ShowOrgContentsParameters parameters});
  Future<Either<Failure,ContentEntity>> showContentByID({required ShowContentByIDParameters parameters});
  Future<Either<Failure,VideoFileEntity>> ShowVideoFileView({required ShowVideoFileParameters parameters});
  Future<Either<Failure,QuizEntity>> showQuestions({required ShowQuestionsParameters parameters});
  Future<Either<Failure,AssignmentEntity>> showAssignmentQuestions({required ShowAssignmentsParameters parameters});
  Future<Either<Failure,List<AnswerCorrectEntity>>> getModelAnswers({required GetModelAnswersParameters parameters});
  Future<Either<Failure,List<AssignmentAnswerEntity>>> getAssignmentModelAnswers({required GetAssignmentModelAnswersParameters parameters});
}