import 'package:e_commerce_app/domain/useCases/sign_up_use_case.dart';
import 'package:e_commerce_app/ui/auth/SignUp/cubit/sign_up_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpStates> {
  SignUpUseCase signUpUseCase;

  SignUpViewModel({required this.signUpUseCase}) : super(SignUpInitialState());
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  signUp() async {
    if(formKey.currentState!.validate()){
      emit(SignUpLoadingState());
      var response = await signUpUseCase.call(
          fullNameController.text,
          emailAddressController.text,
          passwordController.text,
          rePasswordController.text,
          mobileNumberController.text);
      response.fold((error) {
        emit(SignUpErrorState(error: error));
      }, (response) {
        emit(SignUpSuccessState(signUpResponseEntity: response));
      });
    }
  }
}
