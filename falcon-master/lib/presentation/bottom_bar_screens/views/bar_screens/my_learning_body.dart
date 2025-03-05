import 'package:falcon/core/core_exports.dart';

class MyLearningBody extends StatelessWidget {
  const MyLearningBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> GetStudentModulesBloc(getStudentModulesUsecase: sl<GetStudentModulesUsecase>())
        ..add(GetStudentModulesRequestEvent(studentId: int.parse(context.read<CurrentUserBloc>().userData!.id))),
      child: BlocBuilder<GetStudentModulesBloc,GetStudentModulesState>(
          builder: (context , studentModulesResponseState) {
          if(studentModulesResponseState.getModulesRequestState ==RequestState.loading){
            return Skeletonizer(
              child: Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: AppPadding.pHScreen4(context),
                ),
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppPadding.pHScreen2(context),
                    childAspectRatio: AppConstants.wScreen(context)/AppConstants.hScreen(context)/0.65,
                    mainAxisSpacing: AppPadding.pHScreen4(context),
                  ),
                  itemBuilder: (context,index){
                    return CustomModuleItemGrid(isMyLearning: true,module: ModuleEntity(id:"", name: "-----------", image: "", price: "133", startDate: "startDate", endDate: "endDate",imageUrl:"" ,subjects: [] ,description:"-------------------------------------------------------" ),);
                  },
                ),
              ),
            );
          }
          else if(studentModulesResponseState.getModulesRequestState ==RequestState.done ){
            return Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: AppPadding.pHScreen4(context),
              ),
              child: (studentModulesResponseState.modulesResponse.isNotEmpty)?GridView.builder(
                itemCount: studentModulesResponseState.modulesResponse.length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppPadding.pHScreen2(context),
                  childAspectRatio: AppConstants.wScreen(context)/AppConstants.hScreen(context)/0.65,
                  mainAxisSpacing: AppPadding.pHScreen4(context),
                ),
                itemBuilder: (context,index){
                  return CustomModuleItemGrid(isMyLearning: true,module: studentModulesResponseState.modulesResponse[index],);
                },
              )
                  :CustomEmptyComponent(emptyItemType: "module",),
            );
          }
          else{
            return GestureDetector(
              onTap: (){
                context.read<GetStudentModulesBloc>().add(GetStudentModulesRequestEvent(studentId: int.parse(context.read<CurrentUserBloc>().userData!.id)));
              },
              child: Container(
                  width: AppConstants.wScreen(context),
                height: AppConstants.hScreen(context),
                margin: EdgeInsets.symmetric(
                    horizontal: AppPadding.pHScreen4(context),
                    vertical: AppPadding.pVScreen2(context),
                ),
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey,
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsManager.warningImage,
                      height: AppConstants.hScreen(context)*0.05,
                      color: ColorManager.darkGrey.withOpacity(0.6),
                    ),
                    SizedBox(height: AppPadding.pVScreen1(context),),
                    Text(
                      studentModulesResponseState.getModulesMessage,
                      style: getMediumStyle(color: ColorManager.darkGrey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppPadding.pVScreen1(context),),
                    Icon(
                      Icons.refresh,
                      color: ColorManager.darkGrey,
                      size: AppSize.s20,

                    ),

                  ],
                ),
              ),
            );
          }
        }
      ),
    );
  }
}


