import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ShowAllContentsUsecase extends BaseUseCase<List<ContentEntity>,ShowAllContentsParameters>{

  final ContentsBaseRepo contentsBaseRepo;

  ShowAllContentsUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure, List<ContentEntity>>> call(ShowAllContentsParameters parameters) async{
    return contentsBaseRepo.showAllContents(parameters: parameters);
  }


}

class ShowAllContentsParameters extends Equatable {

  final int userId;
  final int chapterId;

  ShowAllContentsParameters({required this.userId ,required this.chapterId});

  @override
  List<Object> get props => [userId];
}