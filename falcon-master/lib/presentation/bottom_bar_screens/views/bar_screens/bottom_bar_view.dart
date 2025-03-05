import 'package:falcon/core/core_exports.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {


  void initState() {
    super.initState();
    _checkLastVideo();
  }

  Future<void> _checkLastVideo() async {
    final lastVideo = await CacheHelper.getData(key: "lastVideo");
    if (lastVideo != null) {
      _showLastVideoDialog(lastVideo :lastVideo);
    }
  }

  void _showLastVideoDialog({required String lastVideo}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text("Replay video?",style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s18),),
          content:  Text("You closed the app while watching a video. Do you want to watch it again?",style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s9)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                CacheHelper.removeData(key: "lastVideo");
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, PageTransition(
                  child: VideoPlayerScreen(link: lastVideo,),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(
                      milliseconds: AppConstants.pageTransition200),
                ));
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainNavBarCubit()),
        BlocProvider(create: (_) => TasksTabBloc()),
      ],
      child: BlocBuilder<MainNavBarCubit, MainNavBarState>(
        builder: (context, state) {
          int currentPge = (state is MainScreenChanged)?  state.currentPage: 0;
          return Scaffold(
           // backgroundColor: Color(0xfffcfcfc),
            appBar:CustomAppBar(
              context: context,
              hasCenterWidget: currentPge==0?true:false,
              hasTitle: currentPge==0?false:true,
              backgroundColor: ColorManager.white,
              elevation: 0,
              centerWidget: Padding(
                padding: EdgeInsets.only(top:AppConstants.hScreen(context)* 0.02,),
                child: Row(
                  children: [
                    SizedBox(
                      width: AppConstants.wScreen(context)*0.14,
                    ),
                    Image.asset(AssetsManager.logo,width: AppConstants.wScreen(context)*0.1,),
                    SizedBox(width: AppConstants.wScreen(context)*0.02,),
                    Text(
                      "Blue FALCON",
                      style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s16),
                    ),

                  ],
                ),
              ),
              title: (state is MainScreenChanged)?state.navNme:"Home",
            ),
            bottomNavigationBar: CustomMainNavBar(currentPge: currentPge,),
            body: (state is MainScreenChanged)?state.page:const HomeBody(),
          );
        },
      ),
    );
  }
}
