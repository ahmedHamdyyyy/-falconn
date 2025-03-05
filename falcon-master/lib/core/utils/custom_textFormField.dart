import 'package:falcon/core/core_exports.dart';
import 'package:falcon/core/resources/resources_exports.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.textStyle,
    this.heightFilled,
    this.widthFilled,
    this.borderColor,
    this.focusBorderColor,
    this.enableFilled,
    this.enableBorder,
    this.backgroundFilled,
    this.prefixIcon,
    this.suffixIcon,
    this.sizePrefixIcon,
    this.sizeSuffixIcon,
    this.obscureText,
    this.textAlignVertical,
    this.keyboardType,
    this.autofocus,
    this.controller,
    this.validation,
    this.maxLength,
    this.maxLines,
    this.inputFormatters,
    this.marginHorizontalSides,
    this.marginVerticalSides,
    this.marginAllSides,
    this.onSubmitted,
    this.onChanged,



  }) : super(key: key);

  final String? hintText ;
  final TextStyle? hintStyle ;
  final String? labelText ;
  final TextStyle? labelStyle ;
  final TextStyle? textStyle ;
  final Color? borderColor ;
  final Color? focusBorderColor ;
  final bool? enableFilled ;
  final bool? enableBorder;
  final Color? backgroundFilled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? sizePrefixIcon;
  final double? sizeSuffixIcon;
  final bool? obscureText;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final double? heightFilled ;
  final double? widthFilled;
  final int? maxLength;
  final int? maxLines;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final double? marginAllSides ;
  final double? marginHorizontalSides ;
  final double? marginVerticalSides ;
  final validation;
  void Function(String text)?  onSubmitted ;
  void Function(String text)?  onChanged ;


  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height*0.065;
    return Padding(
      padding:  (marginAllSides!=null)?EdgeInsets.all(marginAllSides!)
          :EdgeInsets.symmetric(vertical:marginVerticalSides??0 ,
          horizontal: marginHorizontalSides??0),
      child: TextFormField(
        controller: controller,
        validator: validation,
        onFieldSubmitted:onSubmitted,
        onChanged:onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          labelText:labelText,
          labelStyle: labelStyle?? getBoldStyle(color: ColorManager.primary),
          filled: enableFilled ?? true,
          fillColor:backgroundFilled?? const Color(0x0A000000),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: prefixIcon,
          ),
          suffixIcon: suffixIcon,
          prefixIconConstraints: BoxConstraints(
            maxHeight: (sizePrefixIcon!=null)?sizePrefixIcon!+25 :maxHeight*0.9,
            maxWidth: (sizePrefixIcon!=null)?sizePrefixIcon!+25 : maxHeight*0.9,
          ),
          suffixIconConstraints: BoxConstraints(
              maxHeight: (sizeSuffixIcon!=null)?sizeSuffixIcon!+25 :maxHeight*0.9,
              maxWidth: (sizeSuffixIcon!=null)?sizeSuffixIcon!+25 : maxHeight*0.9
          ),
          constraints: BoxConstraints(
            maxHeight: heightFilled ?? maxHeight,
            maxWidth:  widthFilled ?? MediaQuery.of(context).size.width,

          ),
          //contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: ),
          enabledBorder: (enableBorder==true || enableBorder==null)? _buildOutlineBorder() :_buildUnderlineInputBorder(),
          focusedBorder: (enableBorder==true || enableBorder==null)? _buildFocusedOutlineBorder():_buildFocusedUnderlineInputBorder(),
          focusedErrorBorder:  OutlineInputBorder(
            borderRadius:BorderRadius.circular(AppRadius.r8),
            borderSide: BorderSide(
              color:ColorManager.error,
              width: 2,

            ),
          ),
          errorBorder:  OutlineInputBorder(
            borderRadius:BorderRadius.circular(AppRadius.r8),
            borderSide: BorderSide(
              color:ColorManager.error,
              width: 1,


            ),
          ),
        ),
        style: textStyle,
        obscureText: obscureText?? false,
        textAlignVertical: textAlignVertical??TextAlignVertical.center,
        keyboardType:keyboardType ,
        autofocus:autofocus ?? false,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        maxLines: maxLines??1,

      ),
    );
  }



  OutlineInputBorder _buildOutlineBorder() {
    return  OutlineInputBorder(
      borderRadius:BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide(
        color: borderColor?? backgroundFilled?? const Color(0x0A000000),
      ),
    );
  }


  OutlineInputBorder _buildFocusedOutlineBorder() {
    return OutlineInputBorder(
      borderRadius:BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide(
        width: 2,
        color: focusBorderColor ?? ColorManager.primary,
      ),
    );
  }

  UnderlineInputBorder _buildUnderlineInputBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: borderColor ?? ColorManager.primary,
      ),
    );
  }

  UnderlineInputBorder _buildFocusedUnderlineInputBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: focusBorderColor ?? ColorManager.primary,
      ),
    );
  }


}








