import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../entities/sign_Up_Response_Entity.dart';

abstract class AuthRemoteDataSource{
  Future<Either<Failures,SignUpResponseEntity>> createAccount(
      String name,
      String email,
      String password,
      String rePassword,
      );

}