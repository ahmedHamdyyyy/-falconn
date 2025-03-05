import 'package:falcon/core/core_exports.dart';
import 'package:flutter/services.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
        create: (BuildContext context) => GetHomeDataBloc(
            getAdsUseCase: sl<GetAdsUsecase>(),
            getLastChaptersUsecase:  sl<GetLastChaptersUsecase>(),
            getUserModulesUsecase:  sl<GetUserModulesUsecase>())
            ..add(GetAdsEvent())
            ..add(GetLastChaptersEvent())
            ..add(GetLastModulesEvent(userId: int.parse(context.read<CurrentUserBloc>().userData!.id))
            ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomAdsSlider(),
            Column(
              children: [
                LastChapters(),
                SizedBox(height: AppConstants.hScreen(context)*0.03,),
                LastModules(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




