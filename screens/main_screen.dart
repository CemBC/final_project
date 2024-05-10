import 'package:final_project/final_project/database/database.dart';
import 'package:final_project/final_project/widgets/values_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/final_project/screens/asset_screen.dart';
import '../bloc/values_bloc.dart';
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
    return BlocProvider(
      create: (context) => ValuesBloc(), // ValuesBloc'u burada başlatıyoruz
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              if (user != null)
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
                  radius: 25,
                ),
              SizedBox(width: 30),
              Text(user != null ? "${user!.getName()}" : ""),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Text("Stock Market"),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        onLogin: (loggedInUser) {
                          setState(() {
                            user = loggedInUser;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  child: const Text("Login Screen"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssetScreen(user: user),
                    ),
                  );
                },
                child: Container(
                  child: const Text("My Assets"),
                ),
              ),
            ],
          ),
        ),
        body: ShowValuesWidget(user: user),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _increaseTRY();
            if (user != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('100 TRY added to your account'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You must first log in to your account'),
                ),
              );
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}



