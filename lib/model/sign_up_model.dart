class SignUpModel {
  String first_name;
  String last_name;
  String email;
  String phone_number;
  String password;
  String password_confirm;

  SignUpModel({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone_number,
    required this.password,
    required this.password_confirm,
  });

  SignUpModel.fromJson(Map<String, dynamic> json)
      : first_name = json['first_name'],
        last_name = json['last_name'],
        email = json['email'],
        phone_number = json['phone_number'],
        password = json['password'],
        password_confirm = json['password_confirm'];

  Map<String, String> toJson() => {
        "first_name": first_name,
        'last_name': last_name,
        'email': email,
        'phone_number': phone_number,
        'password': password,
        'password_confirm': password_confirm,
      };
}
