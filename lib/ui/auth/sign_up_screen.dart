import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_styles.dart';
import '../../core/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.appLogo),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Full Name",
                  style: AppStyles.W500White18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hintText: "Enter Your Full Name",
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
                  "Mobile Number",
                  style: AppStyles.W500White18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hintText: "Enter Your Mobile Number",
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
                  "E-mail Address",
                  style: AppStyles.W500White18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hintText: "Enter Your Email",
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
              const SizedBox(
                height: 45,
              ),
          
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton.text(
                      onPressed: (){
                        print("object");
                      },
                      text: "Sign Up",
                      buttonColor: AppColors.whiteColor,
                      textColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
