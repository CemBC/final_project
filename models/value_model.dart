class Value{

  String name;

  double value;

  Value({required this.name , required this.value});

  factory Value.fromJson(Map<String , dynamic> json) {
    return Value(
      name: json["name"],
      value: json["value"],
    );
  }


}