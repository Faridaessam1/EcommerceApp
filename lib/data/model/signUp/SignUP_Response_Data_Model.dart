import 'package:e_commerce_app/domain/entities/sign_Up_Response_Entity.dart';

class SignUpResponseDataModel extends SignUpResponseEntity {

  SignUpResponseDataModel({
    super.message,
    super.user,
    super.token,
    super.statusMsg,
  });

  SignUpResponseDataModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserDataModel.fromJson(json['user']) : null;
    token = json['token'];
    statusMsg = json['statusMsg'];
  }
}

class UserDataModel extends UserEntity {
  String? role;

  UserDataModel({
    super.name,
    super.email,
    this.role,
  });

  UserDataModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
}
