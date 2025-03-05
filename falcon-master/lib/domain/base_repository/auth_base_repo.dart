import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

abstract class AuthBaseRepo {
  Future<Either< Failure ,LoginEntity>> getLogin({required LoginParameters parameters});
  Future<Either< Failure ,RegisterEntity>> getRegister({required RegisterParameters parameters});
  Future<Either< Failure ,List<UniversityEntity>>> getUniversities();
}