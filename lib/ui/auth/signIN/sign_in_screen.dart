import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/app_styles.dart';
import 'package:e_commerce_app/core/routes/routes_name.dart';
import 'package:e_commerce_app/core/utils/validation.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/ui/auth/signIN/cubit/sign_in_states.dart';
import 'package:e_commerce_app/ui/auth/signIN/cubit/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/di/di.dart';
import '../../../core/utils/snack_bar_services.dart';

class SignInScreen extends StatelessWidget {
 SignInViewModel signInViewModel = getIt<SignInViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInViewModel , SignInStates>(
      bloc: signInViewModel,
      listener: (context , state){
        if (state is SignInLoadingState) {
          EasyLoading.show();
        } else if (state is SignInErrorState) {
          EasyLoading.dismiss();
          SnackBarServices.showErrorMessage(state.error.errorMsg);
        } else if (state is SignInSuccessState) {
          EasyLoading.dismiss();
          SnackBarServices.showSuccessMessage("Logged In Successfully");
          Navigator.pushNamedAndRemoveUntil(context,RoutesName.home, (route) => false,);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              key: signInViewModel.formKey,
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
                    validator: Validations.validateEmail,
                    controller: signInViewModel.userNameController,
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
                    validator: Validations.validatePassword,
                    controller: signInViewModel.passwordController,
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
                            signInViewModel.SignIn();
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
        ),
      ),
    );
  }
}
