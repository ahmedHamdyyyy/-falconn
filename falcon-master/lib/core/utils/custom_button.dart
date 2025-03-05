import 'package:falcon/core/core_exports.dart';
class CustomButton extends StatelessWidget {
   CustomButton({
    Key? key,
     this.backgroundColor,
     this.heightButton,
     this.widthButton,
     this.elevation,
     this.textStyle,
     this.child,
     this.borderRadius,
     this.isOutlined,
     this.outlinedBorderColor,
     this.marginAllSides,
     this.marginHorizontalSides,
     this.marginVerticalSides,
     this.padding,
     required this.onPressed,
     this.text =" ",
  }) : super(key: key);

   final String? text ;
   final VoidCallback onPressed;
   final bool? isOutlined ;
   final Color? backgroundColor ;
   final double? heightButton ;
   final double? widthButton ;
   final double? elevation ;
   final TextStyle? textStyle ;
   final Color? outlinedBorderColor ;
   final BorderRadiusGeometry? borderRadius ;
   final double? marginAllSides ;
   final double? marginHorizontalSides ;
   final double? marginVerticalSides ;
   final Widget? child ;
   final EdgeInsetsGeometry? padding ;


  @override
  Widget build(BuildContext context) {

    return (isOutlined==null || isOutlined==false) ?
           _buildElevatedButton(context):
           _buildOutlinedButton(context);

  }

  Widget _buildElevatedButton(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height*0.065;
     return Padding(
       padding:  (marginAllSides!=null)?EdgeInsets.all(marginAllSides!)
                 :EdgeInsets.symmetric(vertical:marginVerticalSides??0 ,
                                       horizontal: marginHorizontalSides??0),
       child: ElevatedButton(
         onPressed: onPressed,
         style: ElevatedButton.styleFrom(
           elevation: elevation,
           backgroundColor: backgroundColor ?? ColorManager.primary,
           fixedSize: Size(
             widthButton?? MediaQuery.of(context).size.width,
             heightButton?? maxHeight,
           ),
           shape: RoundedRectangleBorder(
               borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.r10),
           ),
           padding:padding,
         ),

         child: child??Text(
           text!,
           style: textStyle?? getBoldStyle(color: ColorManager.white,fontSize: FontSize.s14) ,
         ),
       ),
     );
   }

  Widget _buildOutlinedButton(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height*0.065;
    return Padding(
           padding:  (marginAllSides!=null)?EdgeInsets.all(marginAllSides!)
                     :EdgeInsets.symmetric(vertical:marginVerticalSides??0 ,
                                           horizontal: marginHorizontalSides??0),
           child: OutlinedButton(
             onPressed: onPressed,
             style: OutlinedButton.styleFrom(
               elevation: elevation,
               backgroundColor: backgroundColor ?? Colors.transparent,
               fixedSize: Size(
                 widthButton?? MediaQuery.of(context).size.width,
                 heightButton?? maxHeight,
               ),
               side: BorderSide(color: outlinedBorderColor??ColorManager.primary),
               shape: RoundedRectangleBorder(
                 borderRadius: borderRadius ??
                     BorderRadius.circular(AppRadius.r10),
               ),
             ),

             child: Text(
                   text!,
                   style: textStyle?? getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s16) ,
                 ),
               ),
         );
  }

}



