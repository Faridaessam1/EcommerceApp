import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/api_network.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/data/model/signUp/Sign_Up_Request_Data_Model.dart';
import 'package:e_commerce_app/data/model/signIn/sign_in_request.dart';
import 'package:e_commerce_app/domain/entities/sign_in_response_entity.dart';
import 'package:e_commerce_app/domain/repositories/dataSource/remote_interFace/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../model/signIn/sign_in_response_data_model.dart';
import '../../model/signUp/SignUP_Response_Data_Model.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiNetwork apiNetwork;

  AuthRemoteDataSourceImpl({required this.apiNetwork});

  @override
  Future<Either<Failures, SignUpResponseDataModel>> createAccount(
    String name,
    String email,
    String password,
    String rePassword,
    String mobileNumber,
  ) async {
    try {
      SignUpRequestDataModel signUpRequestDataModel = SignUpRequestDataModel(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: mobileNumber,
      );

      var response = await apiNetwork.postData(
          endPoint: EndPoints.signUpEndPoint,
          data: signUpRequestDataModel.toJson());
      final signUpResponse = SignUpResponseDataModel.fromJson(response.data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(signUpResponse);
      } else {
        return Left(ServerError(errorMsg: signUpResponse.message!));
      }
    } catch (error) {
      return Left(Failures(errorMsg: error.toString()));
    }
  }

  @override
  Future<Either<Failures, SignInResponseEntity>> login(
      String userName, String password) async {
    try{
      SignInRequest signInRequest = SignInRequest(
        email: userName,
        password: password,
      );


      var response = await apiNetwork.postData(endPoint: EndPoints.signInEndPoint,
          data: signInRequest.toJson());

      final signInResponse = SignInResponseDataModel.fromJson(response.data);



      if(response.statusCode! >= 200 && response.statusCode! < 300){
        return Right(signInResponse);
      }else{

        return Left(ServerError(errorMsg: signInResponse.message));
      }
    } catch(error){
      return Left(Failures(errorMsg: error.toString()));
    }


  }
}

