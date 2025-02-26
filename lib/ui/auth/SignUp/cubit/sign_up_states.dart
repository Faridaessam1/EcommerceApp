import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/sign_Up_Response_Entity.dart';

abstract class SignUpStates{

}

class SignUpInitialState extends SignUpStates{}
class SignUpLoadingState extends SignUpStates{}
class SignUpSuccessState extends SignUpStates{
  SignUpResponseEntity signUpResponseEntity;

  SignUpSuccessState({required this.signUpResponseEntity});
}
class SignUpErrorState extends SignUpStates{
  Failures error;

  SignUpErrorState({required this.error});
}