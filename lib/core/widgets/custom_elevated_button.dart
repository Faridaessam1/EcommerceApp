import 'package:flutter/material.dart';
import '../../main.dart';
import '../constants/app_colors.dart';

class CustomElevatedButton extends StatelessWidget{
  String? text;
  Color? buttonColor;
  Color? textColor;
  Function()? onPressed;
  Widget? child;
  double? fontSize;
  double borderRadius;

  CustomElevatedButton({super.key, 
    this.text,
   this.buttonColor,
     this.textColor,
    this.onPressed,
    this.child,
    this.fontSize = 20,
    this.borderRadius = 16,
  });

  CustomElevatedButton.text({key,
    required String text,
    required Color buttonColor,
    required Color textColor,
    VoidCallback? onPressed,
})
      : this(
    text: text,
    buttonColor: buttonColor,
    textColor: textColor,
    onPressed: onPressed,
  );

  CustomElevatedButton.iconText({key,
    required String text,
    required Color buttonColor,
    required Color textColor,
    VoidCallback? onPressed,
    required String iconImage,
  }) : this(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(iconImage,height: MediaQuery.of(navigatorKey.currentContext!).size.height * 0.03,),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            fontFamily: "InterRegular",
            color: textColor,
          ),
        ),
      ],
    ),
    buttonColor: buttonColor,
    textColor: textColor,
    onPressed: onPressed,
    text: null,
  );
  CustomElevatedButton.iconOnly({
    required Color buttonColor,
    required Image iconImage,
    VoidCallback? onPressed,
  }) : this(
    child: iconImage,
    buttonColor: buttonColor,
    onPressed: onPressed,
    text: null,
    textColor: null,
  );



  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:  buttonColor ,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: AppColors.primaryColor
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: child != null && text != null
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child!,
          SizedBox(width:MediaQuery.of(context).size.width * 0.10),
          Text(
            text!,
            style: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: fontSize,
              fontFamily: "InterRegular",
              color: textColor,
            ),
          ),
        ],
      )
          : child != null
          ? child!
          : Text(text!,
        style: Theme
            .of(context)
            .textTheme
            .titleLarge
            ?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          fontFamily: "InterRegular",
          color: textColor,
        ),
      ),
    );
  }
  }