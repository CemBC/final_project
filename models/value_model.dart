class Value{

  String name;

  double value;

  String image;

  String short;

  Value({required this.name , required this.value , required this.image , required this.short});

  factory Value.fromJson(Map<String , dynamic> json) {
    return Value(
      name: json["name"],
      value: json["value"],
      image: json["image"],
      short: json["short"],
    );
  }


}