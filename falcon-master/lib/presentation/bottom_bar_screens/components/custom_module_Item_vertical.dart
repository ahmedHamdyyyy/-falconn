
import 'package:falcon/core/core_exports.dart';

class CustomModuleItemVertical extends StatelessWidget {
  const CustomModuleItemVertical({
    super.key,
    required this.module,
  });

  final ModuleEntity module;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.hScreen(context)*0.15,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r10),
        border: Border.all(color: ColorManager.lightGrey),
        boxShadow: [
          BoxShadow(
              color: ColorManager.lightGrey,
              offset:Offset(2,2),
              blurRadius: 3,
              spreadRadius: 1
          ),
        ]
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: ()async{
              bool canPayment = (await CacheHelper.getData(key:"canPayment")=="true")?true:false;;
              Navigator.push(context, PageTransition(
                child: DetailsView(
                    isMyLearning: false,
                    type: DetailsType.Module,
                    imageUrl:module.imageUrl,
                    module: module,
                  canPayment: canPayment,
                ),
                type: PageTransitionType.fade,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(milliseconds: AppConstants.pageTransition200),
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left:Radius.circular(AppRadius.r10)),
              child:CachedNetworkImage(
                imageUrl:module.imageUrl!,
                width: AppConstants.wScreen(context)*0.4,
                height: AppConstants.hScreen(context)*0.15,
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
                  width: AppConstants.wScreen(context)*0.4,
                  height: AppConstants.hScreen(context)*0.15,
                  fit: BoxFit.fill,
                ),

              ),
            ),
          ),
          SizedBox(width: AppConstants.wScreen(context)*0.02,),
          Flexible(
            child: GestureDetector(
              onTap: ()async{
                bool canPayment = await fetchPaymentState();
                Navigator.push(context, PageTransition(
                  child: ModuleContentViews(
                      isMyLearning: false,
                      module:module,
                    canPayment: canPayment,
                     ),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));
              },
              child: Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: AppPadding.pHScreen2(context),
                  vertical: AppPadding.pVScreen1(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.name,
                      style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s12),
                    ),
                    Spacer(),
                    Text(
                      module.description,
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                    ),
                    Spacer(),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.access_time_filled, size: AppSize.s11,color: ColorManager.textGrey,),
                        SizedBox(width: AppPadding.pHScreen1(context),),
                        Text(
                          "from : ${module.startDate}",
                          style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s8),
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
                              style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s8),
                            ),
                          ],
                        ),
                        Text(
                          "${double.parse(module.price.toString())}" ,//E£
                          style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s8),
                        ),
                      ],
                    ),
                    Spacer(),
                    Spacer(),

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
