import 'dart:convert';
class User{
  final String username;
  final String password;

  final Map<String, dynamic>? money;

  User({required this.username , required this.password ,  Map<String, dynamic>? money,
  }) : money = money ?? {
    "AUD" : 0.0,
    "JPY" : 0.0,
    "EUR" : 0.0,
    "GBP" : 0.0,
    "USD" : 0.0,
    "TRY" : 100.0,
  };



  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    password: json["password"],
    money: json["money"] != null
        ? Map<String, dynamic>.from(jsonDecode(json["money"]))
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

  Map<String, dynamic>? getMoney() {
    return money;
  }

  void increaseMoney(String currency, double amount) {
    if (money!.containsKey(currency)) {
      money![currency] = (money![currency] ?? 0) + amount;
    }
  }

  void decreaseMoney(String currency, double amount) {
    if (money!.containsKey(currency)) {
      money![currency] = (money![currency] ?? 0) - amount;
    }
  }

  double getCurrencyValue(String currency) {
    return money?[currency] ?? 0.0;
  }
}