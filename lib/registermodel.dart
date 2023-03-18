import 'dart:convert';

RegisterModel RegisterModelFromJson(String str){
  final jsonData = json.decode(str);
  return RegisterModel.fromMap(jsonData);
}
String RegisterModelToJson(RegisterModel data){
  final dyn = data.toMap();
  return json.encode(dyn);
}

class RegisterModel {
  late String username;
  late String age;
  late String city;
  late String mobilenumber;
  late String email;
  late String password;

  RegisterModel({
    required this.username,
    required this.city,
    required this.age,
    required this.mobilenumber,
    required this.email,
    required this.password,
});
  factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
    username: json["user_name"],
    age: json["user_age"],
    city: json["user_city"],
    mobilenumber: json["mobile_number"],
    email: json["user_email"],
    password: json["user_password"],
  );
  Map<String, dynamic> toMap() => {
    "user_name": username,
    "user_age": age,
    "user_city": city,
    "mobile_number": mobilenumber,
    "user_email": email,
    "user_password": password,
  };

  static fromJson(json) {}
}
