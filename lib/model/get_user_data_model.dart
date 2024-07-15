class GetDataUserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  Null? avatar;

  GetDataUserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  GetDataUserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['avatar'] = this.avatar;
    return data;
  }
}
