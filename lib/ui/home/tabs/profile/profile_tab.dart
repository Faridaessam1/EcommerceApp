import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../auth/SignUp/cubit/sign_up_view_model.dart';

class ProfileTab extends StatelessWidget{
  SignUpViewModel signUpViewModel = getIt<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        title: Image.asset(
        AppAssets.appLogo2,
        height: height * 0.25,
        width: width * 0.25,
      ),
    ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             "Welcome ,${signUpViewModel.fullNameController.text}",
              style: AppStyles.W500White18.copyWith(color: AppColors.primaryColor),
            ),
            Text(
              signUpViewModel.emailAddressController.text,
              style: AppStyles.W500White18.copyWith(color: AppColors.primaryColor).copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Form(
                key: signUpViewModel.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Your Name",
                        style: AppStyles.W500White18.copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      validator: Validations.ValidateFullName,
                      controller: signUpViewModel.fullNameController,
                      hintText: signUpViewModel.fullNameController.text,
                      hintTextColor: AppColors.primaryColor,
                      minLines: 1,
                      borderColor: AppColors.primaryColor,
                      filledColor: AppColors.whiteColor,
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Your E-mail",
                        style: AppStyles.W500White18.copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      validator: Validations.validateEmail,
                      controller: signUpViewModel.emailAddressController,
                      hintText: signUpViewModel.emailAddressController.text,
                      hintTextColor: AppColors.primaryColor,
                      minLines: 1,
                      borderColor: AppColors.primaryColor,
                      filledColor: AppColors.whiteColor,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Your Password",
                        style: AppStyles.W500White18.copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      validator: Validations.validatePassword,
                      controller: signUpViewModel.passwordController,
                      isPassword: true,
                      iconColor: AppColors.grayColor,
                      hintText: signUpViewModel.passwordController.text,
                      hintTextColor: AppColors.primaryColor,
                      minLines: 1,
                      borderColor: AppColors.primaryColor,
                      filledColor: AppColors.whiteColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Your Number",
                        style: AppStyles.W500White18.copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      validator: Validations.ValidatePhoneNumber,
                      controller: signUpViewModel.mobileNumberController,
                      hintText: signUpViewModel.mobileNumberController.text,
                      hintTextColor: AppColors.primaryColor,
                      minLines: 1,
                      borderColor: AppColors.primaryColor,
                      filledColor: AppColors.whiteColor,
                    ),
                    const SizedBox(
                      height: 25,
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}