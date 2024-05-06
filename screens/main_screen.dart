import 'package:flutter/material.dart';


import '../models/user_model.dart';
import 'login_screen.dart';
class MainScreen extends StatefulWidget{

  const MainScreen ({super.key});

  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  User? user;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: user != null ? Text("Account: ${user!.getName()}") : null, //!!! assetden profil fotoğrafı eklenecek
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
                          builder: (context) => Placeholder())
                  );
                },
                child: Container(
                    child: const Text("My Assets")))
          ],
        ),


      ),
    );
  }
}


