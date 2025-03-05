import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ShowVideoFileUsecase extends BaseUseCase<VideoFileEntity,ShowVideoFileParameters>{

  final ContentsBaseRepo contentsBaseRepo ;

  ShowVideoFileUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure, VideoFileEntity>> call(ShowVideoFileParameters parameters) async{
    return contentsBaseRepo.ShowVideoFileView(parameters: parameters);
  }


}

class ShowVideoFileParameters extends Equatable {

  final String contentId;

  ShowVideoFileParameters({required this.contentId});

  @override
  List<Object> get props => [contentId];
}