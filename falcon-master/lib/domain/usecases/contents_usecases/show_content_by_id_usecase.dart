import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ShowContentByIdUsecase extends BaseUseCase <ContentEntity, ShowContentByIDParameters>{

  final ContentsBaseRepo contentsBaseRepo ;

  ShowContentByIdUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure, ContentEntity>> call(ShowContentByIDParameters parameters)async {
    return await contentsBaseRepo.showContentByID(parameters: parameters);
  }

}


class ShowContentByIDParameters extends Equatable {

  final int contentId;
  final int type;

  ShowContentByIDParameters({required this.contentId, required this.type});

  @override
  List<Object> get props => [contentId, type];
}