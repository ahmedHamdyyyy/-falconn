import 'dart:io';

import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CustomGeneralInfo extends StatelessWidget {
  CustomGeneralInfo({
    Key? key,
  }) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (_)=>EditProfileApiBloc(editStudentProfileUsecase: sl<EditStudentProfileUsecase>()),
        child: BlocBuilder<EditProfileApiBloc,EditProfileApiState>(

          builder: (context,editProfApiState) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(  // Use only one Flexible or Expanded
                      child: BlocBuilder<EditProfileInfoCubit, EditProfileState>(
                        builder: (context, state) {
                          bool canEditName =
                          (state is EditNameChanged) ? state.canEditName : false;
                          bool canEditPhone =
                          (state is EditPhoneChanged) ? state.canEditPhone : false;
                          bool canEditEmail =
                          (state is EditEmailChanged) ? state.canEditEmail : false;
                          String? nameValue =
                              context.read<EditProfileInfoCubit>().getName;
                          String? phoneValue =
                              context.read<EditProfileInfoCubit>().getPhone;
                          String? emailValue =
                              context.read<EditProfileInfoCubit>().getEmail;

                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppConstants.wScreen(context) * 0.02,
                              vertical: AppConstants.hScreen(context) * 0.02,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: AppConstants.wScreen(context) * 0.04,
                              vertical: AppConstants.hScreen(context) * 0.02,
                            ).copyWith(top: AppConstants.hScreen(context) * 0.08),
                            decoration: BoxDecoration(
                              color: ColorManager.lightGrey.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(AppRadius.r10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: ColorManager.primary,
                                        ),
                                      ),
                                      Text("Edit Profile",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s20),),
                                      SizedBox(),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: AppPadding.pVScreen4(context),
                                ),
                                CustomEditProfileItem(
                                  title: "Name",
                                  editingController: nameController,
                                  editState: EditNameChanged(canEditName: false),
                                  canEdit: canEditName,
                                  value:
                                  "${nameController.text == "" ? (context.read<CurrentUserBloc>().userData!.name) : nameController.text}",
                                  onSubmitted: (text) {
                                    if (RegExp(r'[a-zA-Z0-9]').hasMatch(text)) {
                                      context.read<EditProfileInfoCubit>().setName = text;
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfileName(canEditName: !canEditName);
                                    } else if (text.trim().isEmpty) {
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfileName(canEditName: !canEditName);
                                    } else {
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfileName(canEditName: !canEditName);
                                    }
                                  },
                                  suffixOnTap: () {
                                    context
                                        .read<EditProfileInfoCubit>()
                                        .editProfileName(canEditName: !canEditName);
                                  },
                                ),
                                SizedBox(
                                  height: AppConstants.hScreen(context) * 0.02,
                                ),
                                CustomEditProfileItem(
                                  title: "Phone",
                                  editingController: phoneController,
                                  editState: EditPhoneChanged(canEditPhone: false),
                                  canEdit: canEditPhone,
                                  value:
                                  "${phoneController.text == "" ? (context.read<CurrentUserBloc>().userData!.phone) : phoneController.text}",
                                  onSubmitted: (text) {
                                    if (RegExp(r'[a-zA-Z0-9]').hasMatch(text)) {
                                      context.read<EditProfileInfoCubit>().setPhone = text;
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfilePhone(canEditPhone: !canEditPhone);
                                    } else if (text.trim().isEmpty) {
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfilePhone(canEditPhone: !canEditPhone);
                                    } else {
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfilePhone(canEditPhone: !canEditPhone);
                                    }
                                  },
                                  suffixOnTap: () {
                                    context
                                        .read<EditProfileInfoCubit>()
                                        .editProfilePhone(canEditPhone: !canEditPhone);
                                  },
                                ),
                                SizedBox(
                                  height: AppConstants.hScreen(context) * 0.02,
                                ),
                                CustomEditProfileItem(
                                  title: "Email",
                                  editingController: emailController,
                                  editState: EditEmailChanged(canEditEmail: false),
                                  canEdit: canEditEmail,
                                  value:
                                  "${emailController.text == "" ? (context.read<CurrentUserBloc>().userData!.email) : emailController.text}",
                                  onSubmitted: (text) {
                                    if (RegExp(r'[a-zA-Z0-9]').hasMatch(text)) {
                                      context.read<EditProfileInfoCubit>().setEmail = text;
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfileEmail(canEditEmail: !canEditEmail);
                                    } else if (text.trim().isEmpty) {
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfileEmail(canEditEmail: !canEditEmail);
                                    } else {
                                      context
                                          .read<EditProfileInfoCubit>()
                                          .editProfileEmail(canEditEmail: !canEditEmail);
                                    }
                                  },
                                  suffixOnTap: () {
                                    context
                                        .read<EditProfileInfoCubit>()
                                        .editProfileEmail(canEditEmail: !canEditEmail);
                                  },
                                ),
                                SizedBox(
                                  height: AppConstants.hScreen(context) * 0.04,
                                ),
                                BlocBuilder<GetUniversitiesBloc, GetUniversitiesState>(
                                  builder: (context, GetUniversitiesApiState) {
                                    if (GetUniversitiesApiState.requestState == RequestState.loading) {
                                      return Skeletonizer(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: AppConstants.hScreen(context)*0.06,
                                              margin: EdgeInsets.symmetric(vertical: AppPadding.pVScreen04(context)),
                                              decoration: BoxDecoration(
                                                color: ColorManager.grey.withOpacity(0.6),
                                                borderRadius: BorderRadius.circular(AppRadius.r10),
                                              ),
                                            ),
                                            Container(
                                              height: AppConstants.hScreen(context)*0.06,
                                              margin: EdgeInsets.symmetric(vertical: AppPadding.pVScreen04(context)),
                                              decoration: BoxDecoration(
                                                color: ColorManager.grey.withOpacity(0.6),
                                                borderRadius: BorderRadius.circular(AppRadius.r10),
                                              ),
                                            ),
                                            Container(
                                              height: AppConstants.hScreen(context)*0.06,
                                              margin: EdgeInsets.symmetric(vertical: AppPadding.pVScreen04(context)),
                                              decoration: BoxDecoration(
                                                color: ColorManager.grey.withOpacity(0.6),
                                                borderRadius: BorderRadius.circular(AppRadius.r10),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    if (GetUniversitiesApiState.requestState == RequestState.error) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AssetsManager.errorLogo,
                                              height: AppConstants.hScreen(context)*0.1,
                                            ),
                                            SizedBox(
                                              height: AppPadding.pVScreen4(context),
                                            ),
                                            Flexible(
                                              child: Center(
                                                child: Text(
                                                  'Error: ${GetUniversitiesApiState.getUniversitiesMessage}',
                                                  style: getMediumStyle(color: ColorManager.error),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //child: Image.asset(AssetsManager),
                                      );
                                    }

                                    // Determine the button text based on the user's selections
                                    String buttonText = "Choose university";
                                    if (GetUniversitiesApiState.selectedUniversityId.isNotEmpty && GetUniversitiesApiState.selectedCollegeId.isEmpty) {
                                      buttonText = "Choose college";
                                    } else if (GetUniversitiesApiState.selectedUniversityId.isNotEmpty && GetUniversitiesApiState.selectedCollegeId.isNotEmpty && GetUniversitiesApiState.selectedLevelId.isEmpty) {
                                      buttonText = "Choose level";
                                    } else if (GetUniversitiesApiState.selectedUniversityId.isNotEmpty && GetUniversitiesApiState.selectedCollegeId.isNotEmpty && GetUniversitiesApiState.selectedLevelId.isNotEmpty) {
                                      buttonText = "Submit"; // Final stage when all selections are done
                                    }
                                    return Column(
                                      children: [
                                        Container(
                                          height: AppConstants.hScreen(context)*0.066,
                                          width: AppConstants.wScreen(context),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AppPadding.pHScreen4(context)
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            vertical: AppConstants.hScreen(context) * 0.006,
                                          ),
                                          decoration: BoxDecoration(
                                            color: ColorManager.lightGrey,
                                            border: Border.all(color: ColorManager.black.withOpacity(0.3),),
                                            borderRadius: BorderRadius.circular(AppRadius.r8),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: GetUniversitiesApiState.selectedUniversityId.isNotEmpty ? GetUniversitiesApiState.selectedUniversityId : null,
                                              hint: Text('Select University'),
                                              items: GetUniversitiesApiState.universitiesResponse.map((university) {
                                                return DropdownMenuItem<String>(
                                                  value: university.id,
                                                  child: Text(university.name,style: getMediumStyle(color: ColorManager.black),),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                context.read<GetUniversitiesBloc>().add(UniversitySelectedEvent(value!));
                                                context.read<EditProfileInfoCubit>().editProfileUniversity(selectedId: value);
                                              },
                                            ),
                                          ),
                                        ),
                                        // Dropdown for selecting college (visible if university is selected)
                                        if (GetUniversitiesApiState.collegesResponse.isNotEmpty) ...[
                                          Container(
                                            height: AppConstants.hScreen(context)*0.066,
                                            width: AppConstants.wScreen(context),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AppPadding.pHScreen4(context)
                                            ),
                                            margin: EdgeInsets.symmetric(
                                              vertical: AppConstants.hScreen(context) * 0.006,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorManager.lightGrey,
                                              border: Border.all(color: ColorManager.black.withOpacity(0.3),),
                                              borderRadius: BorderRadius.circular(AppRadius.r8),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: GetUniversitiesApiState.selectedCollegeId.isNotEmpty ? GetUniversitiesApiState.selectedCollegeId : null,
                                                hint: Text('Select College'),
                                                items: GetUniversitiesApiState.collegesResponse.map((college) {
                                                  return DropdownMenuItem<String>(
                                                    value: college.id,
                                                    child: Text(college.name,style: getMediumStyle(color: ColorManager.black),),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  context.read<GetUniversitiesBloc>().add(CollegeSelectedEvent(value!));
                                                  context.read<EditProfileInfoCubit>().editProfileFaculty(selectedId: value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                        // Dropdown for selecting level (visible if college is selected)
                                        if (GetUniversitiesApiState.levelsResponse.isNotEmpty) ...[
                                          Container(
                                            height: AppConstants.hScreen(context)*0.066,
                                            width: AppConstants.wScreen(context),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: AppPadding.pHScreen4(context),
                                              vertical: AppConstants.hScreen(context) * 0.01,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                              vertical: AppConstants.hScreen(context) * 0.006,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorManager.lightGrey,
                                              border: Border.all(color: ColorManager.black.withOpacity(0.3),),
                                              borderRadius: BorderRadius.circular(AppRadius.r8),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: GetUniversitiesApiState.selectedLevelId.isNotEmpty ? GetUniversitiesApiState.selectedLevelId : null,
                                                hint: Text('Select Level'),
                                                items: GetUniversitiesApiState.levelsResponse.map((level) {
                                                  return DropdownMenuItem<String>(
                                                    value: level.id,
                                                    child: Text(level.name,style: getMediumStyle(color: ColorManager.black),),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  context.read<GetUniversitiesBloc>().add(LevelSelectedEvent(value!));
                                                  context.read<EditProfileInfoCubit>().editProfileLevel(selectedId: value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                        // Submit button with dynamic text based on selections
                                        ((GetUniversitiesApiState.selectedUniversityId.isEmpty || GetUniversitiesApiState.selectedCollegeId.isEmpty || GetUniversitiesApiState.selectedLevelId.isEmpty))?Padding(
                                          padding:  EdgeInsets.symmetric(vertical: AppPadding.pVScreen1_5(context)),
                                          child: Text(
                                            "Please $buttonText",
                                            style: getBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s10),
                                          ),
                                        ):SizedBox(),
                                      ],
                                    );
                                  },
                                ),
                                Spacer(),
                                CustomButton(
                                  onPressed: () async{
                                    context.read<EditProfileInfoCubit>().saveNewInfo(
                                        context: context,
                                        newName: nameValue,
                                        newPhone: phoneValue,
                                        newEmail: emailValue);


                                    await context.read<EditProfileApiBloc>()..add(EditProfileApiResponseEvent(
                                      id: int.parse(context.read<CurrentUserBloc>().userData!.id),
                                      name: (nameController.text.isNotEmpty)?nameController.text:(context.read<CurrentUserBloc>().userData!.name),
                                      phone: (phoneController.text.isNotEmpty)?phoneController.text:(context.read<CurrentUserBloc>().userData!.phone),
                                      email: (emailController.text.isNotEmpty)?emailController.text:(context.read<CurrentUserBloc>().userData!.email),
                                      university: context.read<EditProfileInfoCubit>().selectedUniversityId,
                                      faculty: context.read<EditProfileInfoCubit>().selectedFacultyId,
                                      level: context.read<EditProfileInfoCubit>().selectedLevelId,
                                    ));


                                    await Future.delayed(Duration(seconds:2),(){
                                      showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"Success Updating",),);
                                    });


                                  },
                                  text: "Save",
                                ),
                                SizedBox(
                                  height: AppConstants.hScreen(context) * 0.02,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                BlocBuilder<EditProfileApiBloc,EditProfileApiState>(
                    builder: (context,editApiState) {
                      if( editApiState is LoadingEditProfileApi ){

                        return Container(
                          height: AppConstants.hScreen(context),
                          width: AppConstants.wScreen(context),
                          color: Colors.black.withOpacity(0.3),
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
              ],
            );
          }
        ),
      ),
    );
  }
}
