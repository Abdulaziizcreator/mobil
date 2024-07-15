class SignInModel {
  String email;
  String password;


  SignInModel({
    required this.email,
    required this.password,
  });

  SignInModel.fromJson(Map<String, dynamic> json)
      :
        email = json['email'],
        password = json['password'];

  Map<String, String> toJson() => {
    'email': email,
    'password': password,
  };
}
