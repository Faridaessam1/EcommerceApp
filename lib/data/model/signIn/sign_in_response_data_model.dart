import 'package:e_commerce_app/domain/entities/sign_in_response_entity.dart';

class SignInResponseDataModel extends SignInResponseEntity {
  SignInResponseDataModel({
    required super.message,
    required super.user,
    required super.token,
    required super.statusMsg,
  });

  factory SignInResponseDataModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseDataModel(
      message: json["message"],
      token: json["token"],
      user: LoginUserDataModel.fromJson(json["user"]),
      statusMsg: json['statusMsg'],
    );
  }

}

class LoginUserDataModel extends LoginUserEntity {
  LoginUserDataModel({
    required super.name,
    required super.email,
    required super.role,
  });

  factory LoginUserDataModel.fromJson(Map<String, dynamic> json) {
    return LoginUserDataModel(
      name: json["name"],
      email: json["email"],
      role: json["role"],
    );
  }
}
