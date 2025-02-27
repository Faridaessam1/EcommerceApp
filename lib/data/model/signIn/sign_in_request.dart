class SignInRequest {
  String? email;
  String? password;


  SignInRequest({
      String? this.email,
      String? this.password,});


  SignInRequest fromJson(dynamic json) {
    return SignInRequest(
        email : json['email'],
        password : json['password'],
    );
  }

  toJson(){
    return{
      'email' : email,
      'password' : password,
    };
  }

}