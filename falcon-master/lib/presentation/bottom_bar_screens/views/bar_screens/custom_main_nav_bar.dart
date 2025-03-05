import 'package:falcon/core/core_exports.dart';

class CustomMainNavBar extends StatelessWidget {
   CustomMainNavBar({
    Key? key,
     required this.currentPge ,
  }) : super(key: key);

  int currentPge ;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 4,
      selectedLabelStyle: getMediumStyle(color: ColorManager.primary,fontSize: 14).copyWith(overflow: TextOverflow.visible ),
      unselectedLabelStyle: getMediumStyle(color: ColorManager.grey,fontSize: 12).copyWith(overflow: TextOverflow.visible),

      onTap: (index) {
        context.read<MainNavBarCubit>().chooseNavPage(context: context,indexPage: index);
      },
      currentIndex:currentPge,
      items:const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined,size: AppSize.s24,),
          label: "Home",

        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ondemand_video,size: AppSize.s24,),
          label: "My Learning",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.task_outlined,size: AppSize.s24,),
        //   label: "Tasks",
        // ),
       /* BottomNavigationBarItem(
          icon: Icon(Icons.groups_outlined,size: AppSize.s24,),
          label: "Doctors",
        ),*/
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline,size: AppSize.s24,),
          label: "Profile",
        ),
      ],
    );
  }
}
