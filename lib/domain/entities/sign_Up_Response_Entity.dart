///pure classes attributes and constructor

class SignUpResponseEntity {
  String? message;
  UserEntity? user;
  String? token;
  String? statusMsg;

  SignUpResponseEntity({
      this.message, 
      this.user, 
      this.token,
    this.statusMsg,
  });
}

class UserEntity {
  String? name;
  String? email;


  UserEntity({
      this.name, 
      this.email, 

  });
}