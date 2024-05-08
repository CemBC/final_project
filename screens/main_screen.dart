import 'package:final_project/final_project/database/database.dart';
import 'package:flutter/material.dart';

import 'package:final_project/final_project/screens/asset_screen.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
class MainScreen extends StatefulWidget{

  const MainScreen ({super.key});

  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  User? user;

  void _increaseTRY(){
    if(user != null) {
      setState(() {
        user!.increaseMoney("TRY", 100);
        _updateUserDatabase();
      });
    }
  }

  void _updateUserDatabase() async {
    await DatabaseService().updateUser(user!);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if(user != null)
              CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
              radius: 25,
            ),
            SizedBox(width: 30,),
            Text(user != null ? "${user!.getName()}" : ""),
          ],
        )
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text("Stock Market"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            SizedBox(height: 100,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen(
                              onLogin: (loggedInUser) {
                                setState(() {
                                  user = loggedInUser;
                                });
                                Navigator.pop(context);
                              },
                            ),
                      )
                  );
                },
                child: Container(
                    child: const Text("Login Screen")
                )
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssetScreen(user: user))
                  );

                },
                child: Container(
                    child: const Text("My Assets")))
          ],
        ),
      ),
        floatingActionButton:
          FloatingActionButton(
            onPressed: _increaseTRY,
            child: Icon(Icons.add),
          )
    );
  }
}

//There will be floating action button which will add 100 try at each press


