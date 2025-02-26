import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';

import '../../entities/sign_Up_Response_Entity.dart';

abstract class AuthRepositoryInterface{
  Future<Either<Failures,SignUpResponseEntity>> createAccount(
      String name,
      String email,
      String password,
      String rePassword,
      String mobileNumber
      );

}