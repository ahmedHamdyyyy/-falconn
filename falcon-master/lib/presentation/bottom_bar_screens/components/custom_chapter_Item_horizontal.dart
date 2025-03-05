import 'package:falcon/core/core_exports.dart';

class CustomChapterItemHorizontal extends StatelessWidget {
  const CustomChapterItemHorizontal({
    super.key,
    required this.lastChapter,
  });
  final LastChapterEntity lastChapter ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.wScreen(context)*0.42,
      //height: AppConstants.hScreen(context)*0.23,
      margin: EdgeInsets.symmetric(
        vertical: AppPadding.pVScreen1(context),
      ),
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
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top:Radius.circular(AppRadius.r10)),
            child: CachedNetworkImage(
              imageUrl:lastChapter.img!,
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
          Flexible(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding:  EdgeInsets.only(
                    left: AppPadding.pHScreen2(context),
                    right: AppPadding.pHScreen2(context),
                    top: AppPadding.pVScreen08(context),
                    bottom: AppPadding.pVScreen04(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lastChapter.name,
                        style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.library_books_outlined, size: AppSize.s16,color: ColorManager.darkGrey,),
                              SizedBox(width: AppPadding.pHScreen1(context),),
                              Text(
                                lastChapter.course,
                                style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s8),
                              ),
                            ],
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.menu_book_rounded, size: AppSize.s16,color: ColorManager.darkGrey,),
                              SizedBox(width: AppPadding.pHScreen1(context),),
                              Text(
                                lastChapter.subjectName??"there no subject",
                                style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s8),
                              ),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: AppConstants.hScreen(context)*0.01,),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: AppConstants.wScreen(context)*0.004,
                    vertical: AppConstants.wScreen(context)*0.004,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.r4),
                    child: Image.asset(
                      AssetsManager.newIconImage,
                      width: AppConstants.wScreen(context)*0.086,
                      color: ColorManager.green,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}