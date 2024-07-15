class TokenResponseModel {
  String? token;

  TokenResponseModel({
    required this.token,
  });

  TokenResponseModel.fromJson(Map<String, dynamic> map) : token = map['token'];

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
