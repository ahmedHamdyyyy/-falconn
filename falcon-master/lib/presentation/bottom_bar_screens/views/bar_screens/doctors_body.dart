import 'package:falcon/core/core_exports.dart';
import 'package:falcon/core/resources/values_manager.dart';

class DoctorsBody extends StatelessWidget {
  const DoctorsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> GetAllDoctorsBloc(showAllDoctorsUsecase: sl<ShowAllDoctorsUsecase>())
        ..add(GetAllDoctorsRequestEvent()),
      child: BlocBuilder<GetAllDoctorsBloc,GetAllDoctorsState>(
          builder: (context , doctorsResponseState) {
          if(doctorsResponseState.requestState ==RequestState.loading){
            return Skeletonizer(
              child: Padding(
                padding:  EdgeInsets.only(
                  left: AppPadding.pHScreen4(context),
                  right: AppPadding.pHScreen4(context),
                  bottom: AppPadding.pVScreen2(context),
                ),
                child: ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context,index){
                    return CustomDoctor(doctor: DoctorEntity(id:"", image:"", imageUrl:"", name:"----------------", phone:"------------", description: "-------------------------------------------------"),);
                  },
                ),
              ),
            );
          }
          else if (doctorsResponseState.requestState ==RequestState.done){
            return Padding(
              padding:  EdgeInsets.only(
                left: AppPadding.pHScreen4(context),
                right: AppPadding.pHScreen4(context),
                bottom: AppPadding.pVScreen2(context),
              ),
              child: (doctorsResponseState.getDoctorsResponse.isNotEmpty)?ListView.builder(
                itemCount: doctorsResponseState.getDoctorsResponse.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (context,index){
                  return CustomDoctor(doctor: doctorsResponseState.getDoctorsResponse[index],);
                },
              )
                  :CustomEmptyComponent(emptyItemType: "doctor",),
            );
          }
          else {
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
                      doctorsResponseState.responseMessage,
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

class CustomDoctor extends StatelessWidget {
  const CustomDoctor({
    super.key,
    required this.doctor,
  });
  final DoctorEntity doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.wScreen(context),
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pHScreen2(context),
        vertical: AppPadding.pVScreen2(context),
      ).copyWith(bottom: AppPadding.pVScreen08(context),),
      margin: EdgeInsets.symmetric(
        horizontal: AppPadding.pHScreen2(context),
        vertical: AppPadding.pVScreen08(context),
      ),
      decoration: BoxDecoration(
        color: ColorManager.lightGrey,
        borderRadius: BorderRadius.circular(AppRadius.r10,),
        boxShadow: [
          BoxShadow(
              color: ColorManager.grey,
              offset:Offset(1,1),
              blurRadius: 4,
              spreadRadius: 1
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                AssetsManager.image_12,
                height: AppConstants.hScreen(context)*0.08,
                color: ColorManager.darkGrey,
                //width: AppConstants.wScreen(context)*0.4,
              ),
              SizedBox(width: AppPadding.pHScreen2(context),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr: ${doctor.name}",
                    style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s12),
                  ),
                  Text(
                    "${doctor.phone}",
                    style: getMediumStyle(color: ColorManager.primary,fontSize: FontSize.s12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppPadding.pVScreen1(context),),
          Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: AppPadding.pHScreen4(context),
            ),
            child: Text(
              "${doctor.description}",
              textAlign: TextAlign.start,
              style: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
            ),
          ),
        ],
      ),
    );
  }
}
