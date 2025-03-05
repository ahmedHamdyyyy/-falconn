
import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class AuthRepository extends AuthBaseRepo {

  final BaseAuthRemoteDataSource baseAuthRemoteDataSource ;
  AuthRepository({required this.baseAuthRemoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> getLogin({required LoginParameters parameters}) async{
    try {
      final result = await baseAuthRemoteDataSource.loginDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
     // return Left(ServerFailure(errorMessage));
      return Left(ServerFailure(failure.dioException.response?.data["message"]));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, RegisterEntity>> getRegister({required RegisterParameters parameters}) async{
    try {
      final result = await baseAuthRemoteDataSource.registerDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      //return Left(ServerFailure(errorMessage));
      // return Left(ServerFailure(failure.errorMessageModel.message));
      return Left(ServerFailure(failure.dioException.response?.data["message"]));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<UniversityEntity>>> getUniversities() async{
    try {
      final result = await baseAuthRemoteDataSource.UniversitiesDataSource();
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

}