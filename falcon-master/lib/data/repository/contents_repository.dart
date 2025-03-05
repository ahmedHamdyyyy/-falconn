import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ContentsRepository extends ContentsBaseRepo {

  BaseContentsRemoteDataSource baseContentsRemoteDataSource ;
  ContentsRepository({required this.baseContentsRemoteDataSource});

/*  @override
  Future<Either<Failure, VideoFileViewEntity>> ShowVideoMaterialView({required CountVideoViewParameters parameters}) async{
    try {
      final result = await baseContentsRemoteDataSource.countVideoViewDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }*/

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<AdEntity>>> getAds() async{
    try {
      final result = await baseContentsRemoteDataSource.getAdsDataSource();
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<AnswerCorrectEntity>>> getModelAnswers({required GetModelAnswersParameters parameters}) async{
    try {
      final result = await baseContentsRemoteDataSource.getModelAnswersDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }// TODO: implement getModelAnswers
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<ContentEntity>>> showAllContents({required ShowAllContentsParameters parameters}) async{
    try {
      final result = await baseContentsRemoteDataSource.showAllContentsDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, ContentEntity>> showContentByID({required ShowContentByIDParameters parameters}) async{
    try {
      final result = await baseContentsRemoteDataSource.showContentByIDDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, OrgContentsEntity>> showOrgContents({required ShowOrgContentsParameters parameters}) async{
    try {
      final result = await baseContentsRemoteDataSource.showOrgContentsDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, QuizEntity>> showQuestions({required ShowQuestionsParameters parameters}) async{
    try {
      final result = await baseContentsRemoteDataSource.showQuestionsDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, AssignmentEntity>> showAssignmentQuestions({required ShowAssignmentsParameters parameters}) async{
    try {
      final result = await baseContentsRemoteDataSource.showAssignmentQuestionDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {

      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<AssignmentAnswerEntity>>> getAssignmentModelAnswers({required GetAssignmentModelAnswersParameters parameters}) async {
    try {
      final result = await baseContentsRemoteDataSource.getAssignmentModelAnswersDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      print("showAssignmentQuestionDataSource : failure : ${failure.dioException.response}");
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, VideoFileEntity>> ShowVideoFileView({required ShowVideoFileParameters parameters}) async{
    try {
      final result = await baseContentsRemoteDataSource.showVideoFileDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {

      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }




}