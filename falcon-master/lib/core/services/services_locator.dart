import 'package:falcon/core/core_exports.dart';

final sl = GetIt.instance;

class ServicesLocator {

  void init(){


    //useCases
    sl.registerLazySingleton<LoginUsecase>(()=> LoginUsecase(baseAuthRepository: sl()));
    sl.registerLazySingleton<RegisterUsecase>(()=> RegisterUsecase(baseAuthRepository: sl()));
    sl.registerLazySingleton<UniversitiesUsecase>(()=> UniversitiesUsecase(baseAuthRepository: sl()));

    sl.registerLazySingleton<GetLastChaptersUsecase>(()=> GetLastChaptersUsecase(modulesBaseRepo: sl() ));
    sl.registerLazySingleton<GetUserModulesUsecase>(()=> GetUserModulesUsecase(modulesBaseRepo: sl() ));
    sl.registerLazySingleton<GetUserSubjectsUsecase>(()=>GetUserSubjectsUsecase(modulesBaseRepo: sl() ));
    sl.registerLazySingleton<GetUserChaptersUsecase>(()=>GetUserChaptersUsecase(modulesBaseRepo: sl() ));
    sl.registerLazySingleton<GetStudentModulesUsecase>(()=>GetStudentModulesUsecase(modulesBaseRepo:sl()));

    sl.registerLazySingleton<GetAdsUsecase>(()=> GetAdsUsecase(contentsBaseRepo: sl() ));
    sl.registerLazySingleton<ShowContentByIdUsecase>(()=>ShowContentByIdUsecase(contentsBaseRepo: sl() ));
    sl.registerLazySingleton<ShowAllContentsUsecase>(()=>ShowAllContentsUsecase(contentsBaseRepo: sl() ));
    sl.registerLazySingleton<ShowOrgContentsUsecase>(()=>ShowOrgContentsUsecase(contentsBaseRepo: sl() ));
    sl.registerLazySingleton<ShowVideoFileUsecase>(()=>ShowVideoFileUsecase(contentsBaseRepo: sl() ));
    //sl.registerLazySingleton<CountVideoViewUsecase>(()=>CountVideoViewUsecase(contentsBaseRepo: sl() ));
    sl.registerLazySingleton<ShowQuestionsUsecase>(()=>ShowQuestionsUsecase(contentsBaseRepo: sl() ));
    sl.registerLazySingleton<ShowAssignmentsUsecase>(()=>ShowAssignmentsUsecase(contentsBaseRepo: sl() ));
    sl.registerLazySingleton<GetModelAnswerUsecase>(()=>GetModelAnswerUsecase(contentsBaseRepo: sl() ));
    sl.registerLazySingleton<GetAssignmentAnswerUsecase>(()=>GetAssignmentAnswerUsecase(contentsBaseRepo: sl() ));

    sl.registerLazySingleton<ValidateCodeAndChargeUsecase>(()=>ValidateCodeAndChargeUsecase(generalBaseRepo: sl() ));
    sl.registerLazySingleton<ByAnyContentUsecase>(()=>ByAnyContentUsecase(generalBaseRepo: sl() ));
    sl.registerLazySingleton<ShowAllDoctorsUsecase>(()=>ShowAllDoctorsUsecase(generalBaseRepo: sl() ));
    sl.registerLazySingleton<EditStudentProfileUsecase>(()=>EditStudentProfileUsecase(generalBaseRepo: sl() ));
    sl.registerLazySingleton<RateAndCommentUsecase>(()=>RateAndCommentUsecase(generalBaseRepo: sl() ));
    sl.registerLazySingleton<ShowWalletUsecase>(()=>ShowWalletUsecase(generalBaseRepo: sl() ));
    sl.registerLazySingleton<RequestContentUsecase>(()=>RequestContentUsecase(generalBaseRepo: sl() ));
    sl.registerLazySingleton<DeleteAccountUsecase>(()=>DeleteAccountUsecase(generalBaseRepo: sl() ));


    //Repository -------------------------------------------------------------------------------------------------
    sl.registerLazySingleton<AuthBaseRepo>(()=> AuthRepository(baseAuthRemoteDataSource: sl() ));
    sl.registerLazySingleton<ModulesBaseRepo>(()=> ModulesRepository(baseModulesRemoteDataSource: sl() ));
    sl.registerLazySingleton<ContentsBaseRepo>(()=> ContentsRepository(baseContentsRemoteDataSource: sl() ));
    sl.registerLazySingleton<GeneralBaseRepo>(()=> GeneralRepository(baseGeneralRemoteDataSource: sl() ));


    //DataSource -------------------------------------------------------------------------------------------------
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(()=> AuthRemoteDataSource());
    sl.registerLazySingleton<BaseModulesRemoteDataSource>(()=> ModulesRemoteDataSource());
    sl.registerLazySingleton<BaseContentsRemoteDataSource>(()=> ContentsRemoteDataSource());
    sl.registerLazySingleton<BaseGeneralRemoteDataSource>(()=> GeneralRemoteDataSource());


  }

}
//633575
//75069130