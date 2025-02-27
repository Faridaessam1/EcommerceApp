import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/sign_Up_Response_Entity.dart';
import 'package:e_commerce_app/domain/entities/sign_in_response_entity.dart';
import 'package:e_commerce_app/domain/repositories/auth/auth_repository_interface.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/dataSource/remote_interFace/auth_remote_data_source.dart';

@Injectable(as: AuthRepositoryInterface)
class AuthRepositoriesImpl implements AuthRepositoryInterface {
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoriesImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failures, SignUpResponseEntity>> createAccount(String name,
      String email,
      String password,
      String rePassword,
      String mobileNumber,) async {
    var response = await authRemoteDataSource.createAccount(
      name,
      email,
      password,
      rePassword,
      mobileNumber,
    );
    return response.fold(
          (l) => Left(l),
          (r) => Right(r),
    );
  }

  @override
  Future<Either<Failures, SignInResponseEntity>> login(String userName,
      String password) async {
    var response = await authRemoteDataSource.login(userName, password);
    return response.fold(
      (error) => Left(error),
      (response) => Right(response) ,
    );
  }
}
