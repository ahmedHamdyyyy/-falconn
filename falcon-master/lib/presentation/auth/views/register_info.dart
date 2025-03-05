import 'package:falcon/core/core_exports.dart';


class RegisterInfo extends StatefulWidget {
   RegisterInfo({
     required this.phoneRequiredState,
     required this.nameEditingController,
     required this.phoneEditingController,
     required this.emailEditingController,
     required this.passwordEditingController,
     required this.confirmPasswordEditingController,
    Key? key,
  }) : super(key: key);

   bool? phoneRequiredState;
   TextEditingController nameEditingController;
   TextEditingController phoneEditingController;
   TextEditingController emailEditingController;
   TextEditingController passwordEditingController;
   TextEditingController confirmPasswordEditingController;

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
   GlobalKey<FormState> nameSignInfoFormKey = GlobalKey();

   GlobalKey<FormState> phoneSignInfoFormKey = GlobalKey();

   GlobalKey<FormState> emailSignInfoFormKey = GlobalKey();

   GlobalKey<FormState> passwordSignInfoFormKey = GlobalKey();

   GlobalKey<FormState> confirmSignInfoFormKey = GlobalKey();

   bool _passwordIsObscure = true;
   bool _confirmPasswordIsObscure = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        //height: AppConstants.hScreen(context),
        padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen6(context)),
        child: BlocBuilder<RegisterApiBloc,RegisterApiState>(
          builder: (context ,registerState) {
            RegisterApiBloc registerApiBloc = context.read<RegisterApiBloc>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppConstants.hScreen(context) * 0.06,
                ),
                Center(
                  child: Text(
                    "Sign Up",
                    style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),
                  ),
                ),
                SizedBox(
                  height: AppPadding.pVScreen06(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Are you ready to join the",
                      style: getBoldStyle(color: ColorManager.textGrey),
                    ),
                    Text(
                      " FALCON ?",
                      style: getBoldStyle(color: ColorManager.primary,),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppConstants.hScreen(context) * 0.04,
                ),
                Form(
                  key: nameSignInfoFormKey,
                  child: CustomTextFormField(
                    controller: widget.nameEditingController,
                    hintText: "Name",
                    keyboardType: TextInputType.name,
                    marginVerticalSides: AppConstants.hScreen(context) * 0.005,
                    borderColor: ColorManager.black.withOpacity(0.3),
                    hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s14),
                    heightFilled:AppConstants.hScreen(context)*registerApiBloc.heightNamePercentage,
                    prefixIcon: Icon(
                      Icons.person,
                      size: 20,
                      color: ColorManager.black.withOpacity(0.6),
                    ),
                    onSubmitted: (value){
                      nameSignInfoFormKey.currentState!.validate();
                    },
                    validation: (value){
                      return registerApiBloc.nameValidation(name:value.toString() );
                    },
                  ),
                ),
                Form(
                  key: phoneSignInfoFormKey,
                  child: CustomTextFormField(
                    controller: widget.phoneEditingController,
                    hintText: "Phone ${(widget.phoneRequiredState==null ||widget.phoneRequiredState ==false)?"(Optional)":""}",
                    keyboardType: TextInputType.phone,
                    marginVerticalSides: AppConstants.hScreen(context) * 0.005,
                    borderColor: ColorManager.black.withOpacity(0.3),
                    hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s14),
                    heightFilled:AppConstants.hScreen(context)*registerApiBloc.heightPhonePercentage,
                    prefixIcon: Icon(
                      Icons.phone_android,
                      size: 20,
                      color: ColorManager.black.withOpacity(0.6),
                    ),
                    onSubmitted: (value){
                      if(widget.phoneRequiredState==true){
                        phoneSignInfoFormKey.currentState!.validate();
                      }
                    },
                    validation: (value) {
                      if(widget.phoneRequiredState==true){
                        return registerApiBloc.phoneValidation(phone:value.toString() );
                      }
                      return null;
                    },
                  ),
                ),
                Form(
                  key: emailSignInfoFormKey,
                  child: CustomTextFormField(
                    controller: widget.emailEditingController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    marginVerticalSides: AppConstants.hScreen(context) * 0.005,
                    borderColor: ColorManager.black.withOpacity(0.3),
                    hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s14),
                    heightFilled:AppConstants.hScreen(context)*registerApiBloc.heightEmailPercentage,
                    onSubmitted: (value){
                      emailSignInfoFormKey.currentState!.validate();
                    },
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: ColorManager.black.withOpacity(0.6),
                    ),
                    validation: (value) {
                      return registerApiBloc.emailValidation(email:value.toString() );
                    },
                  ),
                ),
                Form(
                  key: passwordSignInfoFormKey,
                  child: CustomTextFormField(
                    controller: widget.passwordEditingController,
                    hintText: "Password",
                    marginVerticalSides: AppConstants.hScreen(context) * 0.005,
                    hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s14),
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
                    heightFilled:AppConstants.hScreen(context)*registerApiBloc.heightPasswordPercentage,
                    obscureText: _passwordIsObscure,
                    onSubmitted: (value){
                      passwordSignInfoFormKey.currentState!.validate();
                    },
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: ColorManager.black.withOpacity(0.6),
                    ),
                    validation: (value) {
                      return registerApiBloc.passwordValidation(password:value.toString() );
                    },
                  ),
                ),
                Form(
                  key: confirmSignInfoFormKey,
                  child: CustomTextFormField(
                    controller: widget.confirmPasswordEditingController,
                    hintText: "Confirm Password",
                    marginVerticalSides: AppConstants.hScreen(context) * 0.005,
                    hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s14),
                    obscureText: _confirmPasswordIsObscure,
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          _confirmPasswordIsObscure = ! _confirmPasswordIsObscure;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon((_confirmPasswordIsObscure)?Icons.visibility_off_rounded:Icons.visibility_rounded,size: 20,color: ColorManager.textGrey.withOpacity(0.8),),
                      ),
                    ),
                    borderColor: ColorManager.black.withOpacity(0.3),
                    heightFilled:AppConstants.hScreen(context)*registerApiBloc.heightConfirmPasswordPercentage,
                    onSubmitted: (value){
                      confirmSignInfoFormKey.currentState!.validate();
                    },
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: ColorManager.black.withOpacity(0.6),
                    ),
                    validation: (value) {
                      return registerApiBloc.confPasswordValidation(password: widget.passwordEditingController.text,confPassword:value.toString() );
                    },
                  ),
                ),

              ],
            );
          }
        ),
      ),
    );
  }
}
