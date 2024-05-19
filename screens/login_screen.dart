import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/user_model.dart';


class LoginScreen extends StatefulWidget {

  final ThemeData themeData;
  final Function(User) onLogin;
  const LoginScreen({required this.onLogin ,required this.themeData});

  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> _checkUserExists(String username, String password) async {
    final bool exist = await _databaseService.isExist(username, password);
    return exist;
  }

  Future<void> _login(String username, String password) async {
    final bool userExists = await _checkUserExists(username, password);
    if (userExists) {
      final User? user = await _databaseService.getUser(username, password);

      if(user!.getMoney() == null) {
        print("Money is null");
      }else{
        print("Money is not null ${user!.getMoney()}");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User Logged in successfully')),
      );
      widget.onLogin(user!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wrong username or password')),
      );
    }
  }

  Future<void> _register(String username, String password) async {
    final userExists = await _checkUserExists(username, password);
    if (userExists) {
      final User? user = await _databaseService.getUser(username, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You already signed up')),
      );

      widget.onLogin(user!);
    } else {
      final user = User(username: username, password: password);
      await _databaseService.createUser(user);
      _databaseService.updateUser(user!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User signed up successfully')),
      );
      widget.onLogin(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Login / Sign up ', style: TextStyle(color: Color(0xFFffc800)),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              child: Icon(Icons.login_rounded , size: 150 , color: Color(0xFF11b81c))
            ),
            SizedBox(height: 50,),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username' , labelStyle: TextStyle(color: Colors.blueGrey)),
              style: TextStyle(color: Colors.cyan),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password' , labelStyle: TextStyle(color: Colors.blueGrey)),
              obscureText: true,
              style: TextStyle(color: Colors.cyan),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    _login(username, password);
                  },
                  child: Text('Login')
                ),
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    _register(username, password);
                  },
                  child: Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: widget.themeData.colorScheme.background,
    );
  }
}