import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../entities/sign_Up_Response_Entity.dart';
import '../../../entities/sign_in_response_entity.dart';

abstract class AuthRemoteDataSource{
  Future<Either<Failures,SignUpResponseEntity>> createAccount(
      String name,
      String email,
      String password,
      String rePassword,
      String mobileNumber,
      );

  Future<Either<Failures,SignInResponseEntity>> login(
      String userName,
      String password,
      );


}