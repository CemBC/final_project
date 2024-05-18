import 'package:flutter/material.dart';
import 'package:final_project/final_project/models/user_model.dart';

class AssetScreen extends StatelessWidget {

  final ThemeData themeData;
  User ?user;

  AssetScreen({required this.user , required this.themeData });

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: true,
        title: Text("Your Assets" , style: TextStyle(color: Color(0xFFffc800) , fontSize: 20 ,
        fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: user != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: user!.getMoney()!.entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${entry.key}: ${entry.value.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16 , color: Colors.redAccent , fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
        )
            : Column(
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
            ),
      ),
      backgroundColor: themeData.colorScheme.background,
    );
  }
}
