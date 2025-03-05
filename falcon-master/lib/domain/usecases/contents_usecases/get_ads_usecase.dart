import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class GetAdsUsecase extends BaseUseCase<List<AdEntity>,NoParameters>{

  final ContentsBaseRepo contentsBaseRepo ;

  GetAdsUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure, List<AdEntity>>> call(NoParameters parameters) async{
    return  await contentsBaseRepo.getAds();
  }


}