import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/routes/routes_name.dart';
import 'package:e_commerce_app/core/utils/snack_bar_services.dart';
import 'package:e_commerce_app/core/utils/validation.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/ui/auth/SignUp/cubit/sign_up_states.dart';
import 'package:e_commerce_app/ui/auth/SignUp/cubit/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/di/di.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpViewModel signUpViewModel = getIt<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpViewModel, SignUpStates>(
      bloc: signUpViewModel,
      listener: (context, state) {
        if (state is SignUpLoadingState) {
          EasyLoading.show();
        } else if (state is SignUpErrorState) {
          EasyLoading.dismiss();
          SnackBarServices.showErrorMessage(state.error.errorMsg);
        } else if (state is SignUpSuccessState) {
          EasyLoading.dismiss();
          SnackBarServices.showSuccessMessage("Account Created Successfully");
          Navigator.pushReplacementNamed(context, RoutesName.signIn);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              key: signUpViewModel.formKey,
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
                    validator: Validations.ValidateFullName,
                    controller: signUpViewModel.fullNameController,
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
                    validator: Validations.ValidatePhoneNumber,
                    controller: signUpViewModel.mobileNumberController,
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
                    validator: Validations.validateEmail,
                    controller: signUpViewModel.emailAddressController,
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
                    validator: Validations.validatePassword,
                    controller: signUpViewModel.passwordController,
                    isPassword: true,
                    iconColor: AppColors.grayColor,
                    hintText: "Enter Your Password",
                    hintTextColor: AppColors.grayColor,
                    minLines: 1,
                    borderColor: AppColors.whiteColor,
                    filledColor: AppColors.whiteColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Confirm Password",
                      style: AppStyles.W500White18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    validator: Validations.validatePassword,
                    controller: signUpViewModel.rePasswordController,
                    isPassword: true,
                    iconColor: AppColors.grayColor,
                    hintText: "Enter Your Password",
                    hintTextColor: AppColors.grayColor,
                    minLines: 1,
                    borderColor: AppColors.whiteColor,
                    filledColor: AppColors.whiteColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton.text(
                          onPressed: () {
                            signUpViewModel.signUp();
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
        ),
      ),
    );
  }
}
