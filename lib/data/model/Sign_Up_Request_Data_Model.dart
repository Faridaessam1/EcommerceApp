class SignUpRequestDataModel {
  String? name;
  String? email;
  String? password;
  String? rePassword;
  String? phone;

  SignUpRequestDataModel({
      this.name, 
      this.email, 
      this.password, 
      this.rePassword, 
      this.phone,});

  SignUpRequestDataModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    rePassword = json['rePassword'];
    phone = json['phone'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['phone'] = phone;
    return map;
  }

}