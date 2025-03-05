import 'package:falcon/core/core_exports.dart';


class OrgContentItem extends StatelessWidget {
  const OrgContentItem({
    super.key,
    required this.contentType,
    required this.items,
    required this.chapterImage,
    required this.chapterId,
    required this.chapterTitle,
  });
  final FileType contentType ;
  final String chapterImage ;
  final String chapterId ;
  final String chapterTitle ;
  final List<ContentEntity>? items ;

  String extractYoutubeId(BuildContext context,String url) {
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );

    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!; // Return the matched video ID
    } else {
      return 'error';
    }
  }
  @override
  Widget build(BuildContext context) {
    if(contentType == FileType.task){
      return CustomAssignmentItem(items:items,chapterImage: chapterImage,chapterTitle: chapterTitle,chapterId: chapterId,);
    }
    else if (contentType == FileType.quiz){
      return CustomQuizItem(chapterId: chapterId,chapterTitle: chapterTitle,items:items,chapterImage: chapterImage,);
    }
    else {
      return GestureDetector(
        onTap: (){
          if(contentType==FileType.file){

          }
          else if (contentType==FileType.video){

          }
        },
        child:  Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: AppPadding.pHScreen4(context),
            vertical: AppPadding.pVScreen1(context),
          ),
          child: ListView.builder(
            itemCount: items?.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  if (contentType==FileType.file){
                    Navigator.push(context, PageTransition(
                      child: PdfViewerPage(pdfPath: "${items?[index].file??""}"),
                      type: PageTransitionType.fade,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      duration: const Duration(milliseconds: AppConstants.pageTransition200),
                    ));
                  }
                  if (contentType==FileType.video){
                    String l = extractYoutubeId(context, items?[index].iframe??"");
                    if(l=="error"){
                      Navigator.push(context, PageTransition(
                        child: ErrorYoutubeLink(),
                        type: PageTransitionType.fade,
                        curve: Curves.fastEaseInToSlowEaseOut,
                        duration: const Duration(milliseconds: 0),
                      ));
                    }else{
                      Navigator.push(context, PageTransition(
                        child: VideoPlayerScreen(link:"${items?[index].iframe}",),
                        type: PageTransitionType.fade,
                        curve: Curves.fastEaseInToSlowEaseOut,
                        duration: const Duration(milliseconds: AppConstants.pageTransition200),
                      ));
                    }
                  }
                },
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    vertical: AppPadding.pVScreen08(context),
                  ),
                  child: Container(
                    width: AppConstants.wScreen(context),
                    height: AppConstants. hScreen(context)*0.1,
                    decoration: BoxDecoration(
                      color: ColorManager.lightGrey,
                      borderRadius: BorderRadius.circular(AppRadius.r10,),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: AppPadding.pHScreen6(context)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.r10),
                          child: Container(
                            width: AppConstants.wScreen(context)*0.13,
                            height: AppConstants.hScreen(context)*0.06,
                            decoration: BoxDecoration(
                            ),
                            child: Image.asset(
                              (contentType==FileType.video)
                                  ? AssetsManager.videoIcon
                                  : AssetsManager.pdfIcon,
                              width: AppConstants.wScreen(context)*0.13,
                              height: AppConstants.hScreen(context)*0.06,
                              fit: BoxFit.cover,

                            ),
                          ),
                        ),
                        SizedBox(width: AppPadding.pHScreen2(context)),
                        Flexible(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(
                              horizontal: AppPadding.pHScreen2(context),
                              vertical: AppPadding.pVScreen2(context),
                            ),
                            child: Text(
                              "${items?[index].name}",
                              style: getBoldStyle(color: ColorManager.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
class ErrorYoutubeLink extends StatelessWidget {
  const ErrorYoutubeLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          context.read<GetStudentModulesBloc>().add(GetStudentModulesRequestEvent(studentId: int.parse(context.read<CurrentUserBloc>().userData!.id)));
        },
        child: Container(
          width: AppConstants.wScreen(context),
          height: AppConstants.hScreen(context),
          margin: EdgeInsets.symmetric(
            horizontal: AppPadding.pHScreen4(context),
            vertical: AppPadding.pVScreen2(context),
          ),
          decoration: BoxDecoration(
            color: ColorManager.lightGrey,
            borderRadius: BorderRadius.circular(AppRadius.r8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsManager.warningImage,
                height: AppConstants.hScreen(context)*0.05,
                color: ColorManager.darkGrey.withOpacity(0.6),
              ),
              SizedBox(height: AppPadding.pVScreen1(context),),
              Text(
                "Cant Open this Video !",
                style: getMediumStyle(color: ColorManager.darkGrey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppPadding.pVScreen1(context),),
              Icon(
                Icons.refresh,
                color: ColorManager.darkGrey,
                size: AppSize.s20,

              ),

            ],
          ),
        ),
      ),
    );
  }
}