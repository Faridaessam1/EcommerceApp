class SignInResponseEntity {
  String message;
  LoginUserEntity user;
  String token;
  String? statusMsg;


  SignInResponseEntity({
    required this.message,
    required this.user,
    required this.token,
    required this.statusMsg,

  });
}

class LoginUserEntity {
  String name;
  String email;
  String role;

  LoginUserEntity({
    required this.name,
    required this.email,
    required this.role,
  });
}
