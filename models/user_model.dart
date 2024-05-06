import 'dart:convert';
class User{
  final String username;
  final String password;

  final Map<String, int>? money;

  User({required this.username , required this.password ,  Map<String, int>? money,
  }) : money = money ?? {
    "USD": 0,
    "EUR": 0,
    "JPY": 0,
    "GBP": 0,
    "AUD": 0,
    "TRY": 0,
  };



  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    password: json["password"],
    money: json["money"] != null
        ? Map<String, int>.from(json["money"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "money": money,
  };

  String getName() {
    return username;
  }

  Map<String, int>? getMoney() {
    return money;
  }
}