import 'package:falcon/core/core_exports.dart';

class CustomModuleItemGrid extends StatelessWidget {
  const CustomModuleItemGrid({
    super.key,
    required this.module,
    required this.isMyLearning,
  });
  final ModuleEntity module ;
  final bool isMyLearning ;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppPadding.pHScreen1(context),
        vertical:AppPadding.pHScreen1(context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r10),
          border: Border.all(color: ColorManager.lightGrey),
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
                color: ColorManager.lightGrey,
                offset:Offset(0.4,0.4),
                blurRadius: 3,
                spreadRadius: 1
            ),
          ]
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()async{
              bool canPayment = (await CacheHelper.getData(key:"canPayment")=="true")?true:false;
              Navigator.push(context, PageTransition(
                child: DetailsView(
                  isMyLearning: isMyLearning,
                  type: DetailsType.Module,
                  imageUrl: module.imageUrl,
                  module: module,
                  canPayment: canPayment,
                ),
                type: PageTransitionType.fade,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(milliseconds: AppConstants.pageTransition200),
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top:Radius.circular(AppRadius.r10)),
              child:CachedNetworkImage(
                imageUrl:module.imageUrl!,
                width: double.infinity,
                height: AppConstants.hScreen(context)*0.14,
                fit: BoxFit.cover,
                placeholder: (context, url) => Skeletonizer(
                    child: Container(
                      color: ColorManager.lightGrey,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AssetsManager.defaultImage,
                  width: double.infinity,
                  height: AppConstants.hScreen(context)*0.14,
                  fit: BoxFit.fill,
                ),

              ),
            ),
          ),
          SizedBox(height: AppConstants.hScreen(context)*0.01,),
          Flexible(
            child: GestureDetector(
              onTap: ()async{
                bool canPayment = (await CacheHelper.getData(key:"canPayment")=="true")?true:false;;
                Navigator.push(context, PageTransition(
                  child: ModuleContentViews(
                      isMyLearning: isMyLearning,
                      module: module,
                    canPayment: canPayment,
                    ),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));
              },
              child: Padding(
                padding:  EdgeInsets.only(
                  left: AppPadding.pHScreen2(context),
                  right: AppPadding.pHScreen2(context),
                  bottom: AppPadding.pVScreen1(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.name,
                      style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                    ),
                    Spacer(),
                    Text(
                      "${module.description}",
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s8),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.access_time_filled, size: AppSize.s11,color: ColorManager.textGrey,),
                        SizedBox(width: AppPadding.pHScreen1(context),),
                        Text(
                          "from : ${module.startDate}",
                          style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s7),
                        ),
                      ],
                    ),
                    SizedBox(height: AppPadding.pVScreen04(context),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time_filled, size: AppSize.s11,color: ColorManager.textGrey,),
                            SizedBox(width: AppPadding.pHScreen1(context),),
                            Text(
                              "To : ${module.endDate}",
                              style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s7),
                            ),
                          ],
                        ),
                        Text(
                          "${double.parse(module.price.toString())} " ,//E£
                          style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s8),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}