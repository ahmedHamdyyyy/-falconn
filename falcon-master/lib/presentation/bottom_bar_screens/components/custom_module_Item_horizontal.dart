import 'package:falcon/core/core_exports.dart';

class CustomModuleItemHorizontal extends StatelessWidget {
  const CustomModuleItemHorizontal({
    super.key,
    required this.index,
  });
  final int index ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.wScreen(context)*0.42,
      height: AppConstants.hScreen(context)*0.214,
      decoration: BoxDecoration(
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
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top:Radius.circular(AppRadius.r10)),
            child: Image.asset(
              AssetsManager.image_6,
              width: double.infinity,
              height: AppConstants.hScreen(context)*0.14,
              fit: BoxFit.cover,

            ),
          ),
          SizedBox(height: AppConstants.hScreen(context)*0.01,),
          Flexible(
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
                    "Module ${index+1}",
                    style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s12),
                  ),
                  Spacer(),
                  Text(
                    "Bold union text resizing align selection image align hand. Object opacity image.",
                    style: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s8),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined, size: AppSize.s16,color: ColorManager.darkGrey,),
                          SizedBox(width: AppPadding.pHScreen1(context),),
                          Text(
                            "01-8-2024",
                            style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s8),
                          ),
                        ],
                      ),
                      Text(
                        "250.0",//E£
                        style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s8),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
