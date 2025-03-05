import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ShowOrgContentsUsecase extends BaseUseCase<OrgContentsEntity,ShowOrgContentsParameters>{

  final ContentsBaseRepo contentsBaseRepo ;

  ShowOrgContentsUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure, OrgContentsEntity>> call(ShowOrgContentsParameters parameters) async{
     return await contentsBaseRepo.showOrgContents(parameters: parameters);
  }


}

class ShowOrgContentsParameters extends Equatable {

  final int userId;
  final int chapterId;

  ShowOrgContentsParameters({required this.userId ,required this.chapterId });

  @override
  List<Object> get props => [userId];
}