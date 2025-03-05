import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterPageView extends StatefulWidget {
   RegisterPageView({super.key,required this.phoneRequiredState});

  bool? phoneRequiredState ;

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {

  late TextEditingController nameEditingController;
  late TextEditingController phoneEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  late TextEditingController confirmPasswordEditingController;

  @override
  void initState() {
    nameEditingController = TextEditingController();
    phoneEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    confirmPasswordEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    phoneEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    return Stack(
      children: [
        Scaffold(
          body: Stack(
            children: [
              BlocConsumer<RegisterApiBloc,RegisterApiState>(
                  listener: (context,registerResponseState){
                    if(registerResponseState is RegisterApiRequestState && registerResponseState.requestState==RequestState.done){

                      showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"Register successful try login now",),);
                      Navigator.pop(context);

                      // Navigator.push(context, PageTransition(
                      //   child: BottomBarView(),
                      //   type: PageTransitionType.fade,
                      //   curve: Curves.fastEaseInToSlowEaseOut,
                      //   duration: const Duration(milliseconds: AppConstants.pageTransition400),
                      // ));
                      //
                      // context.read<CurrentUserBloc>().add(SaveCurrentUserEvent(userData: registerResponseState.registerResponse?.user));
                      //
                      // CacheHelper.saveData(key: "isSigned", value: true);
                      // CacheHelper.saveData(key: "id", value: registerResponseState.registerResponse?.user.id);
                      // CacheHelper.saveData(key: "name", value:registerResponseState.registerResponse?.user.name);
                      // CacheHelper.saveData(key: "email", value: registerResponseState.registerResponse?.user.email);
                      // CacheHelper.saveData(key: "phone", value: registerResponseState.registerResponse?.user.phone);
                      // CacheHelper.saveData(key: "fcmToken", value: registerResponseState.registerResponse?.user.fcmToken);
                      // CacheHelper.saveData(key: "university", value: registerResponseState.registerResponse?.user.university);
                      // CacheHelper.saveData(key: "faculty", value: registerResponseState.registerResponse?.user.faculty);
                      // CacheHelper.saveData(key: "level", value:registerResponseState.registerResponse?.user.level);

                    }

                    if(registerResponseState is RegisterApiRequestState && registerResponseState.requestState==RequestState.error){
                      showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:registerResponseState.RegisterMessage,),);
                    }
                  },
                  builder: (context,registerState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          height: AppConstants.hScreen(context)*0.75,
                          padding: EdgeInsets.only(top: AppPadding.pVScreen8(context)),
                          child: PageView(
                            controller: _pageController,
                            onPageChanged:(index){
                              context.read<RegisterPageBloc>().add(PageChangedEvent(index));
                            },
                            children: [
                              RegisterInfo(
                                phoneRequiredState:widget.phoneRequiredState,
                                  nameEditingController: nameEditingController,
                                  phoneEditingController: phoneEditingController,
                                  emailEditingController: emailEditingController,
                                  passwordEditingController: passwordEditingController,
                                  confirmPasswordEditingController: confirmPasswordEditingController,
                                 ),
                              RegisterPath(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen6(context)),
                        child: Column(
                          children: [
                            BlocBuilder<RegisterPageBloc, RegisterPageState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: AppConstants.hScreen(context) * 0.02,
                                    ),
                                    SmoothPageIndicator(
                                      controller: _pageController,
                                      count: 2,
                                      effect: CustomizableEffect(
                                        activeDotDecoration: DotDecoration(
                                          width: AppSize.s24,
                                          height: AppSize.s8,
                                          color: ColorManager.primary,
                                          rotationAngle: 0,
                                          borderRadius: BorderRadius.circular(AppRadius.r10),
                                        ),
                                        dotDecoration: DotDecoration(
                                          width: AppSize.s10,
                                          height: AppSize.s10,
                                          color: ColorManager.darkGrey.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(AppRadius.r24),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: AppConstants.hScreen(context) * 0.03,
                                    ),
                                    BlocBuilder<GetUniversitiesBloc, GetUniversitiesState>(
                                        builder: (context, GetUniversitiesResponseState) {
                                        return CustomButton(
                                          onPressed: () {
                                              if (context.read<RegisterPageBloc>().state.currentPage < 1) {
                                                FocusScope.of(context).unfocus();
                                                _pageController.nextPage(
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              } else {
                                                RegisterApiBloc  registerApi= context.read<RegisterApiBloc>();
                                                if(registerApi.nameValidation(name: nameEditingController.text) !=null){
                                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:registerApi.nameValidation(name: nameEditingController.text)!,),);
                                                }
                                                else if(registerApi.phoneValidation(phone: phoneEditingController.text) !=null && widget.phoneRequiredState==true){
                                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:registerApi.phoneValidation(phone: phoneEditingController.text)!,),);
                                                }
                                                else if(registerApi.emailValidation(email: emailEditingController.text) !=null){
                                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:registerApi.emailValidation(email: emailEditingController.text)!,),);
                                                }
                                                else if(registerApi.passwordValidation(password: passwordEditingController.text) !=null){
                                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:registerApi.passwordValidation(password: passwordEditingController.text)!,),);
                                                }
                                                else if(registerApi.confPasswordValidation( password: passwordEditingController.text,confPassword: confirmPasswordEditingController.text) !=null){
                                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:registerApi.confPasswordValidation(password: passwordEditingController.text,confPassword: confirmPasswordEditingController.text)!,),);
                                                }
                                                //-----------------------------------------------
                                                else if(GetUniversitiesResponseState.selectedUniversityId==""){
                                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"* University is required"),);
                                                }
                                                else if(GetUniversitiesResponseState.selectedCollegeId==""){
                                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"* College is required"));
                                                }
                                                else if(GetUniversitiesResponseState.selectedLevelId==""){
                                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"* Level is required"));
                                                }
                                                else{
                                                  context.read<RegisterApiBloc>().add(RegisterRequestEvent(
                                                      name:nameEditingController.text,
                                                      email: emailEditingController.text,
                                                      phone: (phoneEditingController.text.isEmpty)?" ":phoneEditingController.text,
                                                      password: passwordEditingController.text,
                                                      university:GetUniversitiesResponseState.selectedUniversityId,
                                                      faculty:GetUniversitiesResponseState.selectedCollegeId,
                                                      level:GetUniversitiesResponseState.selectedLevelId,
                                                      fcmtoken: "1234",
                                                  ));
                                                }


                                            }

                                          },
                                          text: context.read<RegisterPageBloc>().state.currentPage < 1? 'Next':'Sign Up',
                                        );
                                      }
                                    ),
                                    SizedBox(
                                      height: AppConstants.hScreen(context) * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "already have account ?  ",
                                          style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Login",
                                            style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),

                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
              BlocBuilder<RegisterApiBloc,RegisterApiState>(
                  builder: (context,registerResponseState) {
                    if(registerResponseState is RegisterApiRequestState && registerResponseState.requestState==RequestState.loading){
                      return Container(
                        height: AppConstants.hScreen(context),
                        width: AppConstants.wScreen(context),
                        color: ColorManager.black.withOpacity(0.1),
                        alignment: Alignment.bottomCenter,
                        padding:  EdgeInsets.only(bottom:AppPadding.pVScreen4(context)),
                        child: Lottie.asset(
                          AssetsManager.lottieLoading1,
                          width: AppConstants.wScreen(context)*0.5,

                        ),
                      );
                    }
                    return SizedBox();

                  }
              ),
            ],
          ),
        ),
        BlocBuilder<GetUniversitiesBloc,GetUniversitiesState>(
            builder: (context,universityResponse) {
              if(universityResponse.requestState==RequestState.loading){
                return Container(
                  height: AppConstants.hScreen(context),
                  width: AppConstants.wScreen(context),
                  color: Colors.black.withOpacity(0.1),
                  alignment: Alignment.bottomCenter,
                  padding:  EdgeInsets.only(bottom:AppConstants.hScreen(context)*0.25),
                  child: Lottie.asset(
                    AssetsManager.lottieLoading1,
                    width: AppConstants.wScreen(context)*0.5,

                  ),
                );
              }
              return SizedBox();

            }
        ),
        CustomRectangleImageBack(),


      ],
    );
  }
}
