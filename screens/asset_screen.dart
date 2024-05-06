import 'package:flutter/material.dart';
import 'package:final_project/final_project/models/user_model.dart';

import '../database/database.dart';
class AssetScreen extends StatelessWidget {

  User ?user;


  AssetScreen({required this.user });

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: user != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Assets:'),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: user!.getMoney()!.entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${entry.key}: ${entry.value}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        )
            : Text("You must first login"),
      ),
    );
  }
}
