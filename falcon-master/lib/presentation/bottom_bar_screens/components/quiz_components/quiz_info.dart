import 'package:falcon/core/core_exports.dart';

class QuizInfo extends StatelessWidget {
    QuizInfo({
    super.key,
    required this.quizState,
    required this.questions,
    required this.pageController,
    required this.chapterImage,
    required this.quizTimer,
    required this.name,
  });

   final QuizLoaded quizState ;
   final List<QuestionEntity> questions;
    PageController pageController ;
    String?  chapterImage ;
    String?  quizTimer ;
    String?  name ;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.06),
        border: Border.symmetric(horizontal: BorderSide(color: ColorManager.grey.withOpacity(0.6),width: 1.4)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: AppConstants.hScreen(context)*0.07,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pHScreen4(context),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                  child: SizedBox(
                    height: AppConstants.hScreen(context)*0.11,
                    width: AppConstants.wScreen(context)*0.27,
                    child:CachedNetworkImage(
                      imageUrl:chapterImage!,
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
                        height: AppConstants.hScreen(context)*0.11,
                        width: AppConstants.wScreen(context)*0.27,
                        fit: BoxFit.fill,
                      ),

                    ),
                  ),
                ),
                SizedBox(
                  width: AppConstants.wScreen(context)*0.03,
                ),
                SizedBox(
                  width: AppConstants.wScreen(context)*0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$name",
                        style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: AppPadding.pVScreen08(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${questions.length} Questions",
                                  style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                                ),
                                Text(
                                  "",
                                  //"Timer : ${(int.parse(quizTimer!) ~/ 60).toString().padLeft(2, '0')}:${(int.parse(quizTimer!) % 60).toString().padLeft(2, '0')} ",
                                  style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                                ),
                                Text(
                                  "",
                                  style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                                ),
                              ],
                            ),
                            BlocBuilder<TimerBloc, TimerState>(
                              builder: (context, state) {
                                if (state is TimerInitial) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<TimerBloc>(context).add(StartTimer(int.parse(quizTimer??"0")));
                                    },
                                    child: Text('Start Exam'),
                                  );
                                } else if (state is TimerRunning) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: AppConstants.wScreen(context)*0.14,
                                        width: AppConstants.wScreen(context)*0.14,
                                        child: CircularProgressIndicator(
                                          value: state.remainingTime / 120,
                                          strokeWidth: 4.0,
                                          backgroundColor: ColorManager.grey,
                                        ),
                                      ),
                                      Text(
                                        '${(state.remainingTime ~/ 60).toString().padLeft(2, '0')}:${(state.remainingTime % 60).toString().padLeft(2, '0')}',
                                        style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                      ),
                                    ],
                                  );
                                } else if (state is TimerStopped) {
                                  Navigator.pop(context);
                                  return GestureDetector(
                                    onTap: () {
                                      // Start the timer with a duration of 300 seconds (5 minutes)
                                     // BlocProvider.of<TimerBloc>(context).add(StartTimer(int.parse(quizTimer??"0")));
                                    },
                                    child: Text(
                                      'Time\'s up!',
                                      style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppPadding.pVScreen1_5(context),
          ),
          Divider(
            color: ColorManager.grey.withOpacity(0.7),
            thickness: 1.4,
          ),
          Container(
            height: AppConstants.hScreen(context)*0.07,
            decoration: BoxDecoration(
              //color: ColorManager.lightGrey,
            ),
            child: ListView.builder(
              itemCount: questions.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pHScreen2(context),
                vertical: 0,
              ),
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: AppConstants.pageTransition300),
                      curve: Curves.linearToEaseOut,
                    );
                  },
                  child: Container(
                    height: AppConstants.hScreen(context)*0.1,
                    width: AppConstants.wScreen(context)*0.1,
                    margin: EdgeInsets.only(
                      right: AppPadding.pHScreen1(context),
                    ),
                    child: Center(
                      child: Container(
                        height: AppConstants.hScreen(context)*0.09,
                        width: AppConstants.wScreen(context)*0.09,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.white,width:1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${index+1}",
                            style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s12),
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: quizState.selectedAnswers[index] != null?ColorManager.primary:ColorManager.darkGrey.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}