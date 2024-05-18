import 'package:final_project/final_project/database/database.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../models/value_model.dart';

class BuySellScreen extends StatelessWidget {

  final DatabaseService _databaseService = DatabaseService();

  User? user;

  Value value;

  BuySellScreen({required this.user , required this.value});

  void _buy(BuildContext context) {
    if(user!.getCurrencyValue("TRY") == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Not enough currency")),
      );
    }else {
      double result = (user!.getCurrencyValue("TRY") / value.value);
      user!.increaseMoney(value.short, result);
      user!.decreaseMoney("TRY", user!.getCurrencyValue("TRY"));
      _databaseService.updateUser(user!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Purchase successful")),
      );
      Navigator.pop(context);
    }
  }

  void _sell(BuildContext context) {
    if(user!.getCurrencyValue(value.short) == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Not enough currency")),
      );
    }else {
      double result = (user!.getCurrencyValue(value.short) * value.value);
      user!.decreaseMoney(value.short, user!.getCurrencyValue(value.short));
      user!.increaseMoney("TRY", result);
      _databaseService.updateUser(user!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sale successful")),
      );
      Navigator.pop(context);
    }
  }

  Widget build (BuildContext context) {
    if(user == null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            automaticallyImplyLeading: true,
          ),
        body: Column(
          children: [
            Container(
                height: 500,
                width: 500,
                child: Icon(Icons.lock_person_outlined, size: 300, color: Colors.red )
            ),
            Text("You must first login" , style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
                fontSize: 20
            ) ),
          ],
        )
      );
    }else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
                radius: 25,
              ),
              SizedBox(width: 30),
              Text(user != null ? "${user!.getName()}" : "" ,
                style: TextStyle(color: Colors.white),),
              SizedBox(width: 10,),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: 300,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Colors.yellowAccent, Colors.blueGrey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 3),
                  ],
                ),
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
                         Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18,
                                  color: Colors.black)),
                              Text("1 ${value.short} = ${value.value} TRY",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),

                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyanAccent , width: 4) ,
                  borderRadius: BorderRadius.circular(10),

                ),
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Text("You have "
                      "${(user!.getCurrencyValue(value.short)).toStringAsFixed(2)}"
                      " ${value.short}"),
                ),
              ),
              SizedBox(height: 100),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                      onPressed: () => _buy(context),
                      child: Text("Buy ${value.short}"),
                    ),
                    SizedBox(width: 75,),
                    FilledButton(
                      onPressed: () => _sell(context),
                      child: Text("Sell ${value.short}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

}