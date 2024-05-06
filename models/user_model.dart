import 'dart:convert';
class User{
  final String username;
  final String password;
  final int? id;

  User({required this.username , required this.password , required this.id});


  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    password: json["password"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "id": id,
  };

}