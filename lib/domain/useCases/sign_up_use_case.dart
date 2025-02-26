import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/domain/repositories/auth/auth_repository_interface.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/failures.dart';
import '../entities/sign_Up_Response_Entity.dart';

@injectable
class SignUpUseCase {
  AuthRepositoryInterface authRepositoryInterface;

  SignUpUseCase({required this.authRepositoryInterface});

  Future<Either<Failures, SignUpResponseEntity>> call(
    String name,
    String email,
    String password,
    String rePassword,
      String mobileNumber,
  ) {
    return authRepositoryInterface.createAccount(
        name, email, password, rePassword , mobileNumber );
  }
}
