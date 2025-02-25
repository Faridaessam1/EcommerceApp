import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/routes/routes_name.dart';
import 'package:e_commerce_app/core/utils/validation.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                  controller: _fullNameController,
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
                  controller: _mobileNumberController,
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
                  controller: _emailAddressController,
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
                  controller: _passwordController,
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
                        onPressed: (){
                          Navigator.pushNamed(context,RoutesName.signIn);
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
    );
  }
}
