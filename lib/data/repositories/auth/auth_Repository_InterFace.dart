import 'package:e_commerce_app/domain/entities/sign_Up_Response_Entity.dart';

abstract class AuthRepositoryInterface {
  Future<SignUpResponseEntity> createAccount(
    String name,
    String email,
    String password,
    String rePassword,
  );
}
