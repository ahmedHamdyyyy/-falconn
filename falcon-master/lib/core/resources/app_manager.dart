import 'package:device_preview/device_preview.dart';
import 'package:falcon/core/core_exports.dart';

class MyApp extends StatefulWidget {
  // named constructor
  MyApp._internal();

  static final MyApp _instance = MyApp
      ._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DeveloperModeDetectionBloc()..add(CheckDeviceStatus()),),
        BlocProvider(create:(context)=>LoginApiBloc(loginUsecase: sl<LoginUsecase>()),),
        BlocProvider(create:(context)=>RegisterApiBloc(registerUseCase: sl<RegisterUsecase>()),),
        BlocProvider(create:(context)=>CurrentUserBloc()),
        BlocProvider(create:(context)=>RateAndCommentBloc(rateAndCommentUsecase: sl<RateAndCommentUsecase>())),
        BlocProvider(create: (context)=>ValidateCodeChargeBloc(validateCodeChargeUsecase: sl<ValidateCodeAndChargeUsecase>())),
        BlocProvider(create: (context)=>ByAnyContentBloc(byAnyContentUsecase: sl<ByAnyContentUsecase>())),
        BlocProvider(create: (context)=>RequestContentBloc(requestContentUsecase: sl<RequestContentUsecase>())),
        BlocProvider(create: (context)=> GetModelAnswersBloc(getModelAnswerUsecase: sl<GetModelAnswerUsecase>())),
        BlocProvider(create: (context)=> GetAssignmentAnswerBloc(getAssignmentAnswerUsecase: sl<GetAssignmentAnswerUsecase>())),
        BlocProvider(create: (context)=> GetUniversitiesBloc(universitiesUsecase: sl<UniversitiesUsecase>())..add(GetUniversitiesRequestEvent())),


      ],
      child: MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.generateRoute,
        initialRoute: StringRoutes.splashRoute,
        theme: getApplicationTheme(context),
      ),
    );
  }
}

//////////////////////////////////////////



class NormalModeScreen extends StatelessWidget {
  final bool isJailbroken;

  NormalModeScreen({required this.isJailbroken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Jailbroken: ${isJailbroken ? "YES" : "NO"}'),
            Text('Developer mode: NO'),
          ],
        ),
      ),
    );
  }
}