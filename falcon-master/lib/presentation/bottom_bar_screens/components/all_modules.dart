import 'package:falcon/core/core_exports.dart';

class AllModules extends StatelessWidget {
  const AllModules({
    super.key,
    required this.modules,

  });

  final List<ModuleEntity> modules ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        context: context,
        title: "All Modules",
        hasArrowBack: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: AppPadding.pHScreen4(context),
        ),
        child: (modules.isNotEmpty)?GridView.builder(
          itemCount: modules.length,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppPadding.pHScreen2(context),
            childAspectRatio: AppConstants.wScreen(context)/AppConstants.hScreen(context)/0.63,
            mainAxisSpacing: AppPadding.pHScreen4(context),
          ),
          itemBuilder: (context,index){
            return CustomModuleItemGrid(isMyLearning: false,module: modules[index],);
          },
        ):CustomEmptyComponent(
          emptyItemType: "module",),
      ),
    );
  }
}
