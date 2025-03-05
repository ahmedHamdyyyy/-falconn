import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

abstract class GeneralBaseRepo {
  Future<Either<Failure, ChargeCodeEntity>> validateCodeAndCharge({required ValidateCodeAndChargeParameters parameters});
  Future<Either<Failure,ByContentEntity>> byAnyContent({required  ByAnyContentParameters parameters});
  Future<Either<Failure,RequestContentEntity>> requestContent({required  RequestContentParameters parameters});
  Future<Either<Failure, List<DoctorEntity>>> showAllDoctors();
  Future<Either<Failure, WalletEntity>> showWallet({required ShowWalletParameters parameters});
  Future<Either<Failure, ProfileEntity>> editStudentProfile({required EditStudentProfileParameters parameters});
  Future<Either<Failure, RateEntity>> rateAndComment({required RateAndCommentParameters parameters});
  Future<Either<Failure, String>>deleteAccount({required DeleteAccountParameters parameters});
}




