class Value{

  String name;

  double value;

  String image;


  Value({required this.name , required this.value , required this.image });

  factory Value.fromJson(Map<String , dynamic> json) {
    return Value(
      name: json["name"],
      value: json["value"],
      image: json["image"],
    );
  }


}