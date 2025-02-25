import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/app_styles.dart';
import 'package:e_commerce_app/core/routes/routes_name.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(AppAssets.appLogo),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Welcome Back To Route",
                  style: AppStyles.W600Whithe24,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Please sign in with your mail",
                  style: AppStyles.W300White16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "User Name",
                  style: AppStyles.W500White18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hintText: "Enter Your Name",
                hintTextColor: AppColors.grayColor,
                minLines: 1,
                borderColor: AppColors.whiteColor,
                filledColor: AppColors.whiteColor,
              ),
              const SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Password",
                  style: AppStyles.W500White18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                isPassword: true,
                iconColor: AppColors.grayColor,
                hintText: "Enter Your Password",
                hintTextColor: AppColors.grayColor,
                minLines: 1,
                borderColor: AppColors.whiteColor,
                filledColor: AppColors.whiteColor,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Forgot Password?",
                  style:
                      AppStyles.W500White18.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton.text(
                      onPressed: () {
                        print("object");
                      },
                      text: "Login",
                      buttonColor: AppColors.whiteColor,
                      textColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.signUp);
                },
                child: Text(
                  "Don’t have an account? Create Account",
                  style: AppStyles.W500White18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
