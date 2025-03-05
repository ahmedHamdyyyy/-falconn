import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

abstract class ModulesBaseRepo {

  Future<Either<Failure,List<LastChapterEntity>>> getLastChapters();
  Future<Either<Failure,List<ModuleEntity>>> getUserModules({required GetUserModulesParameters parameters});
  Future<Either<Failure,List<SubjectEntity>>> getUserSubjects({required GetUserSubjectsParameters parameters});
  Future<Either<Failure,List<ChapterEntity>>> getUserChapters({required GetUserChaptersParameters parameters});
  Future<Either<Failure,List<ModuleEntity>>> getStudentModules({required GetStudentModulesParameters parameters});
}