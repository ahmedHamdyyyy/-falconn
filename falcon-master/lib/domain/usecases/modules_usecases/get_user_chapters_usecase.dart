import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class GetUserChaptersUsecase extends BaseUseCase<List<ChapterEntity>,GetUserChaptersParameters>{

  final ModulesBaseRepo modulesBaseRepo;

  GetUserChaptersUsecase({required this.modulesBaseRepo});

  @override
  Future<Either<Failure, List<ChapterEntity>>> call(GetUserChaptersParameters parameters) async {
    return await modulesBaseRepo.getUserChapters(parameters: parameters);
  }


}

class GetUserChaptersParameters extends Equatable {
  final int subjectId;
  final int userId;

  GetUserChaptersParameters({required this.subjectId, required this.userId});

  @override
  List<Object> get props => [subjectId, userId];
}