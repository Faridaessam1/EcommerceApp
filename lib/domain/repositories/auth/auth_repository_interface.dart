import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/sign_in_response_entity.dart';

import '../../entities/sign_Up_Response_Entity.dart';

abstract class AuthRepositoryInterface{
  Future<Either<Failures,SignUpResponseEntity>> createAccount(
      String name,
      String email,
      String password,
      String rePassword,
      String mobileNumber
      );

  Future<Either<Failures,SignInResponseEntity>> login(
      String email,
      String password,
      );

}