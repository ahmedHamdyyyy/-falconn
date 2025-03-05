import 'package:falcon/core/core_exports.dart';

class RegisterPath extends StatefulWidget {
  const RegisterPath({super.key});

  @override
  State<RegisterPath> createState() => _RegisterPathState();
}

class _RegisterPathState extends State<RegisterPath> {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GetUniversitiesBloc, GetUniversitiesState>(
      builder: (context, state) {
        if (state.requestState == RequestState.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.requestState == RequestState.error) {
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
                      'Error: ${state.getUniversitiesMessage}',
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
        if (state.selectedUniversityId.isNotEmpty && state.selectedCollegeId.isEmpty) {
          buttonText = "Choose college";
        } else if (state.selectedUniversityId.isNotEmpty && state.selectedCollegeId.isNotEmpty && state.selectedLevelId.isEmpty) {
          buttonText = "Choose level";
        } else if (state.selectedUniversityId.isNotEmpty && state.selectedCollegeId.isNotEmpty && state.selectedLevelId.isNotEmpty) {
          buttonText = "Submit"; // Final stage when all selections are done
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pHScreen6(context)),
          child: Column(
            children: [
              SizedBox(height: AppConstants.hScreen(context) * 0.06),
              Center(
                child: Text("Sign Up", style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18)),
              ),
              SizedBox(height: AppPadding.pVScreen1(context)),
              Center(child: Text("Choose your path", style: getBoldStyle(color: ColorManager.textGrey))),
              SizedBox(height: AppConstants.hScreen(context) * 0.04),
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
                    value: state.selectedUniversityId.isNotEmpty ? state.selectedUniversityId : null,
                    hint: Text('Select University'),
                    items: state.universitiesResponse.map((university) {
                      return DropdownMenuItem<String>(
                        value: university.id,
                        child: Text(university.name,style: getMediumStyle(color: ColorManager.black),),
                      );
                    }).toList(),
                    onChanged: (value) {
                      context.read<GetUniversitiesBloc>().add(UniversitySelectedEvent(value!));

                    },
                  ),
                ),
              ),
              // Dropdown for selecting college (visible if university is selected)
              if (state.collegesResponse.isNotEmpty) ...[
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
                      value: state.selectedCollegeId.isNotEmpty ? state.selectedCollegeId : null,
                      hint: Text('Select College'),
                      items: state.collegesResponse.map((college) {
                        return DropdownMenuItem<String>(
                          value: college.id,
                          child: Text(college.name,style: getMediumStyle(color: ColorManager.black),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<GetUniversitiesBloc>().add(CollegeSelectedEvent(value!));
                      },
                    ),
                  ),
                ),
              ],
              // Dropdown for selecting level (visible if college is selected)
              if (state.levelsResponse.isNotEmpty) ...[
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
                      value: state.selectedLevelId.isNotEmpty ? state.selectedLevelId : null,
                      hint: Text('Select Level'),
                      items: state.levelsResponse.map((level) {
                        return DropdownMenuItem<String>(
                          value: level.id,
                          child: Text(level.name,style: getMediumStyle(color: ColorManager.black),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context.read<GetUniversitiesBloc>().add(LevelSelectedEvent(value!));
                      },
                    ),
                  ),
                ),
              ],
              // Submit button with dynamic text based on selections
              ((state.selectedUniversityId.isEmpty || state.selectedCollegeId.isEmpty || state.selectedLevelId.isEmpty))?Padding(
                padding:  EdgeInsets.symmetric(vertical: AppPadding.pVScreen1_5(context)),
                child: Text(
                  "Please $buttonText",
                  style: getBoldStyle(color: ColorManager.primary),
                ),
              ):SizedBox(),
            ],
          ),
        );
      },
    );
    // return SingleChildScrollView(
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: AppPadding.pHScreen6(context)),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         SizedBox(height: AppConstants.hScreen(context) * 0.06),
    //         Center(
    //           child: Text("Sign Up", style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18)),
    //         ),
    //         SizedBox(height: AppPadding.pVScreen1(context)),
    //         Center(child: Text("Choose your path", style: getBoldStyle(color: ColorManager.textGrey))),
    //         SizedBox(height: AppConstants.hScreen(context) * 0.04),
    //         UniversityMenuWidget(),
    //         SizedBox(height: AppConstants.hScreen(context) * 0.01),
    //         FacultyMenuWidget(),
    //         SizedBox(height: AppConstants.hScreen(context) * 0.01),
    //         LevelMenuWidget(),
    //       ],
    //     ),
    //   ),
    // );
  }
}


// class RegisterPath extends StatefulWidget {
//   const RegisterPath({super.key});
//
//   @override
//   State<RegisterPath> createState() => _RegisterPathState();
// }
//
// class _RegisterPathState extends State<RegisterPath> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         //height: AppConstants.hScreen(context),
//         padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen6(context)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: AppConstants.hScreen(context) * 0.06,
//             ),
//             Center(
//               child: Text(
//                 "Sign Up",
//                 style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),
//               ),
//             ),
//             SizedBox(
//               height: AppPadding.pVScreen1(context),
//             ),
//             Center(
//               child: Text(
//                 "Choose your path",
//                 style: getBoldStyle(color: ColorManager.textGrey),
//               ),
//             ),
//             SizedBox(
//               height: AppConstants.hScreen(context) * 0.04,
//             ),
//             UniversityMenuWidget(),
//             SizedBox(
//               height: AppConstants.hScreen(context) * 0.01,
//             ),
//             FacultyMenuWidget(),
//             SizedBox(
//               height: AppConstants.hScreen(context) * 0.01,
//             ),
//             LevelMenuWidget(),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
