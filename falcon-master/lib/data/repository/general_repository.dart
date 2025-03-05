import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GeneralRepository extends GeneralBaseRepo {

  BaseGeneralRemoteDataSource baseGeneralRemoteDataSource ;
  GeneralRepository({required this.baseGeneralRemoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> editStudentProfile({required EditStudentProfileParameters parameters}) async{
    try {
      final result = await baseGeneralRemoteDataSource.editStudentProfileDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, RateEntity>> rateAndComment({required RateAndCommentParameters parameters}) async{
    try {
      final result = await baseGeneralRemoteDataSource.rateAndCommentDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, List<DoctorEntity>>> showAllDoctors() async{
    try {
      final result = await baseGeneralRemoteDataSource.showAllDoctorsDataSource();
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, ChargeCodeEntity>> validateCodeAndCharge({required ValidateCodeAndChargeParameters parameters}) async{
    try {
      final result = await baseGeneralRemoteDataSource.validateCodeAndChargeDataSource(parameters: parameters);

      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      //return Left(ServerFailure(errorMessage));
      return Left(ServerFailure(failure.dioException.response?.data["error"]));
    }
  }

  //----------------------------------------------------------------------------



  @override
  Future<Either<Failure, WalletEntity>> showWallet({required ShowWalletParameters parameters}) async{
    try {
      final result = await baseGeneralRemoteDataSource.showWalletDataSource(parameters: parameters);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);
      return Left(ServerFailure(errorMessage));
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, ByContentEntity>> byAnyContent({required ByAnyContentParameters parameters}) async{
    try {
      final result = await baseGeneralRemoteDataSource.byAnyContentDataSource(parameters: parameters,);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);

      return Left(ServerFailure(failure.dioException.response?.data["error"]));
      //return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, RequestContentEntity>> requestContent({required RequestContentParameters parameters})async{
    try {
      final result = await baseGeneralRemoteDataSource.requestContentDataSource(parameters: parameters,);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);

      return Left(ServerFailure(failure.dioException.response?.data["message"]));
      //return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount({required DeleteAccountParameters parameters}) async{
    try {
      final result = await baseGeneralRemoteDataSource.deleteAccountDataSource(parameters: parameters,);
      return Right(result);
    } on ServerException catch (failure) {
      final errorMessage = ApiConstants().handelDioException(exception: failure.dioException);

      return Left(ServerFailure(errorMessage));
    }
  }


}