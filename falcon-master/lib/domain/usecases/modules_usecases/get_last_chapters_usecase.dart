import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class GetLastChaptersUsecase extends BaseUseCase<List<LastChapterEntity>,NoParameters> {

  final ModulesBaseRepo modulesBaseRepo ;

  GetLastChaptersUsecase({required this.modulesBaseRepo});

  @override
  Future<Either<Failure, List<LastChapterEntity>>> call(NoParameters parameters) async{
    return await modulesBaseRepo.getLastChapters();
  }


}