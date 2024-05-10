import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/value_model.dart';

class ValuesListItem extends StatelessWidget {
  User? user;
  Value value;

  ValuesListItem({required this.value, required this.user});

  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Colors.green, Colors.yellow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 3),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: AssetImage("assets/images/${value.image}"),
                radius: 75,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("1 ${value.name} = ${value.value} TRY",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.cyanAccent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                child: Icon(
                  Icons.download,
                  color: Colors.cyanAccent,
                  size: 40,
                ),
                onTap: () {


                },
              )
          ),
        ],
      ),
    );
  }
}
