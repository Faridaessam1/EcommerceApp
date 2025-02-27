import 'package:e_commerce_app/domain/entities/sign_in_response_entity.dart';

import '../../../../core/errors/failures.dart';

class SignInStates{}

class SignInInitialState extends SignInStates{}
class SignInLoadingState extends SignInStates{}
class SignInErrorState extends SignInStates{
  Failures error;

  SignInErrorState({required this.error});
}
class SignInSuccessState extends SignInStates{
  SignInResponseEntity signInResponseEntity;

  SignInSuccessState({required this.signInResponseEntity});
}