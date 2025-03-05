import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginBody extends StatefulWidget {
   LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  late GlobalKey<FormState> loginFormKey ;

  bool _passwordIsObscure = true;

  @override
  void initState() {
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    loginFormKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomRectangleImageBack(),
        Stack(
          children: [
            BlocConsumer<LoginApiBloc,LoginApiState>(
              listener: (context,loginResponseState){
                  if(loginResponseState is LoginApiRequestState && loginResponseState.requestState==RequestState.done){

                    showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:loginResponseState.loginMessage,),);

                    Navigator.pushAndRemoveUntil(context, PageTransition(
                      child: BottomBarView(),
                      type: PageTransitionType.fade,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      duration: const Duration(milliseconds: AppConstants.pageTransition300),
                    ),(Route<dynamic> route) => false);
                    context.read<CurrentUserBloc>().add(SaveCurrentUserEvent(userData: loginResponseState.loginResponse?.user));

                    CacheHelper.saveData(key: "isSigned", value: true);
                    CacheHelper.saveData(key: "id", value: loginResponseState.loginResponse?.user.id);
                    CacheHelper.saveData(key: "id", value: loginResponseState.loginResponse?.user.id);
                    CacheHelper.saveData(key: "name", value:loginResponseState.loginResponse?.user.name);
                    CacheHelper.saveData(key: "email", value: loginResponseState.loginResponse?.user.email);
                    CacheHelper.saveData(key: "phone", value: loginResponseState.loginResponse?.user.phone);
                    CacheHelper.saveData(key: "university", value: loginResponseState.loginResponse?.user.university);
                    CacheHelper.saveData(key: "faculty", value: loginResponseState.loginResponse?.user.faculty);
                    CacheHelper.saveData(key: "level", value:loginResponseState.loginResponse?.user.level);
                    CacheHelper.saveData(key: "fcmToken", value: loginResponseState.loginResponse?.user.fcmToken);

                  }

                  if(loginResponseState is LoginApiRequestState && loginResponseState.requestState==RequestState.error){
                    showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:loginResponseState.loginMessage,),);
                  }
                },
              builder: (context,loginResponseState) {
                LoginApiBloc loginBlocData = context.read<LoginApiBloc>();
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen6(context)),
                  child: Form(
                    key:loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppConstants.hScreen(context) * 0.22,
                        ),
                        Center(
                          child: Image.asset(
                            AssetsManager.logo,
                            height:AppConstants.hScreen(context)*0.14,
                          ),
                        ),
                        SizedBox(
                          height: AppConstants.hScreen(context) * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome to ",
                              style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                            ),
                            Text(
                              "BLUE FALCON",
                              style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s14),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: AppConstants.hScreen(context) * 0.04,
                        ),
                        CustomTextFormField(
                          controller: emailEditingController,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          marginVerticalSides: AppConstants.hScreen(context) * 0.02,
                          borderColor: ColorManager.black.withOpacity(0.3),
                          hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s14),
                          heightFilled:AppConstants.hScreen(context)*loginBlocData.heightEmailPercentage,
                          prefixIcon: Icon(
                            Icons.phone_android,
                            size: AppSize.s20,
                            color: ColorManager.black.withOpacity(0.6),
                          ),
                          validation: (value){
                            return loginBlocData.emailValidation(email:value.toString() );
                          },
                        ),
                        CustomTextFormField(
                          controller: passwordEditingController,
                          hintText: "Password",
                          hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s14),
                          obscureText: _passwordIsObscure,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                _passwordIsObscure = ! _passwordIsObscure;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon((_passwordIsObscure)?Icons.visibility_off_rounded:Icons.visibility_rounded,size: 20,color: ColorManager.textGrey.withOpacity(0.8),),
                            ),
                          ),
                          borderColor: ColorManager.black.withOpacity(0.3),
                          heightFilled:AppConstants.hScreen(context)*loginBlocData.heightPasswordPercentage,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size:AppSize.s20,
                            color: ColorManager.black.withOpacity(0.6),
                          ),
                            validation: (value){
                              return loginBlocData.passwordValidation(password:value.toString() );
                            },
                        ),
                        const Spacer(),
                        CustomButton(
                          onPressed: () {
                            loginBlocData.add(LoginRequestEvent(
                              email: emailEditingController.text,
                              password: passwordEditingController.text,
                              loginFormKey: loginFormKey,
                            ));
                          },
                          text: "Login",
                        ),
                        SizedBox(
                          height: AppConstants.hScreen(context) * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You don't have account ?  ",
                              style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                            ),
                            InkWell(
                              onTap: () async{
                                bool phoneRequiredState =  await fetchPhoneRequired();
                                Navigator.push(context, PageTransition(
                                  child: MultiBlocProvider(
                                    providers: [
                                      BlocProvider(create: (context) => RegisterPageBloc()),
                                      // BlocProvider(create: (context) => UniversityBloc()),
                                      // BlocProvider(create: (context) => FacultyMenuBloc()),
                                      // BlocProvider(create: (context) => LevelMenuBloc()),
                                    ],
                                    child: RegisterPageView(phoneRequiredState:phoneRequiredState),
                                  ),
                                  type: PageTransitionType.fade,
                                  curve: Curves.fastEaseInToSlowEaseOut,
                                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                                ));

                              },
                              child: Text(
                                "Sign Up",
                                style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppConstants.hScreen(context) * 0.2,
                        ),

                      ],
                    ),
                  ),
                );
              }
            ),
            BlocBuilder<LoginApiBloc,LoginApiState>(
              builder: (context,loginResponseState) {
                if(loginResponseState is LoginApiRequestState && loginResponseState.requestState==RequestState.loading){
                    return Container(
                      height: AppConstants.hScreen(context),
                      width: AppConstants.wScreen(context),
                      color: ColorManager.black.withOpacity(0.3),
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

      ],
    );
  }

}
