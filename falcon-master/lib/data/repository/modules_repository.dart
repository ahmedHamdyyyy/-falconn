import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ModulesRepository extends ModulesBaseRepo {

  BaseModulesRemoteDataSource baseModulesRemoteDataSource ;
  ModulesRepository({required this.baseModulesRemoteDataSource});

  @override
  Future<Either<Failure, List<LastChapterEntity>>> getLastChapters() async{
    try {
      final result = await baseModulesRemoteDataSource.getLastChaptersDataSource();
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<ModuleEntity>>> getStudentModules({required GetStudentModulesParameters parameters}) async{
    try {
      final result = await baseModulesRemoteDataSource.getStudentModulesDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<ChapterEntity>>> getUserChapters({required GetUserChaptersParameters parameters}) async{
    try {
      final result = await baseModulesRemoteDataSource.getUserChaptersDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<ModuleEntity>>> getUserModules({required GetUserModulesParameters parameters}) async{
    try {
      final result = await baseModulesRemoteDataSource.getUserModulesDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<SubjectEntity>>> getUserSubjects({required GetUserSubjectsParameters parameters}) async{
    try {
      final result = await baseModulesRemoteDataSource.getUserSubjectsDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

}