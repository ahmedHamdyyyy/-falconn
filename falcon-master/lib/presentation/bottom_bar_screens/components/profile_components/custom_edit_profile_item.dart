import 'package:falcon/core/core_exports.dart';

class CustomEditProfileItem extends StatelessWidget {
  CustomEditProfileItem({
     super.key,
     required this.title,
     required this.editingController,
     required this.value,
     required this.canEdit,
     required this.editState,
     this.onSubmitted,
     this.suffixOnTap,
  });

  final String title;
  final String value;
  final bool canEdit;
  final EditProfileState editState;
  final TextEditingController editingController;
  final Function(String text)? onSubmitted;
  final Function()? suffixOnTap;

  @override
  Widget build(BuildContext context) {
    final double _heightScreen = MediaQuery.of(context).size.height;
    final double _widthScreen = MediaQuery.of(context).size.width;

    return Container(
      height: (canEdit) ? _heightScreen * 0.12 : _heightScreen * 0.1,
      padding: EdgeInsets.symmetric(horizontal: _widthScreen * 0.06, vertical: _heightScreen * 0.01),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(color: ColorManager.lightGrey,width: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: getBoldStyle(color: ColorManager.primary),
          ),
          SizedBox(
            height: _heightScreen * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (canEdit)
                  ? CustomTextFormField(
                      hintText: "$value",
                      controller: editingController,
                      textStyle: getRegularStyle(color: ColorManager.black),
                      hintStyle: getRegularStyle(color: ColorManager.darkGrey),
                      widthFilled: _widthScreen * 0.7,
                      heightFilled: _heightScreen * 0.04,
                      enableBorder: false,
                      borderColor: ColorManager.textGrey.withOpacity(0.5),
                      enableFilled: false,
                      autofocus: true,
                      onSubmitted: onSubmitted,
                      suffixIcon: GestureDetector(
                          onTap:suffixOnTap,
                          child: Icon(Icons.check),
                       ),
                  )
                  : Text(
                      "$value",
                      style: getMediumStyle(color: ColorManager.textGrey,fontSize:FontSize.s16),
                  ),
              GestureDetector(
                onTap: () {
                  if (editState is EditNameChanged) {
                    context.read<EditProfileInfoCubit>().editProfileName(canEditName: !canEdit);
                  }
                  if (editState is EditPhoneChanged) {
                    context.read<EditProfileInfoCubit>().editProfilePhone(canEditPhone: !canEdit);
                  }
                  if (editState is EditEmailChanged) {
                    context.read<EditProfileInfoCubit>().editProfileEmail(canEditEmail: !canEdit);
                  }

                  // todo ::=> read cubit here ::
                },
                child: Container(
                  child: (canEdit)
                      ? SizedBox()
                      : Image.asset(
                    AssetsManager.pen,
                    width: _widthScreen * 0.05,
                    color: ColorManager.darkGrey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}