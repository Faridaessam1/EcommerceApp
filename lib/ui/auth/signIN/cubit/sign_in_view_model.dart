import 'package:e_commerce_app/domain/useCases/sign_in_use_case.dart';
import 'package:e_commerce_app/ui/auth/signIN/cubit/sign_in_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInViewModel extends Cubit<SignInStates> {
  SignInUseCase signInUseCase;

  SignInViewModel({required this.signInUseCase}) : super(SignInInitialState());

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignIn() async {
    if(formKey.currentState!.validate()){

    emit(SignInLoadingState());
    var response = await signInUseCase.call(
      userNameController.text,
      passwordController.text,
    );
    response.fold(
    (error) {
      emit(SignInErrorState(error: error));
    },
    (response) {
      emit(SignInSuccessState(signInResponseEntity: response));
    } ,
    );
  }
  }
}
