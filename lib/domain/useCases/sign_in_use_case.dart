import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/sign_in_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth/auth_repository_interface.dart';

@injectable
class SignInUseCase {
  AuthRepositoryInterface authRepositoryInterface;

  SignInUseCase({required this.authRepositoryInterface});

  Future<Either<Failures, SignInResponseEntity>> call(
      String email, String password) {
    return authRepositoryInterface.login(email, password);
  }
}
