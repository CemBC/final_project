import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/user_model.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final DatabaseService _databaseService = DatabaseService();

  Future<bool> _checkUserExists(BuildContext context , username, String password) async {
    final Future<bool> exist = _databaseService.isExist(username, password);
    if(await exist) {
      return true;
    }else{
      return false;
    }
  }
  Future<void> _login(BuildContext context, String username, String password) async {
    final bool userExists = await _checkUserExists(context ,username, password);
    if (userExists) {

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wrong username or password')),
      );
    }
  }

  Future<void> _register(BuildContext context, String username, String password) async {

    final userExists = await _checkUserExists(context , username, password);
    if (userExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You already signed up')),
      );
    } else {
      final user = User(username: username , password: password);
      _databaseService.createUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User signed up successfully')),
      );
    }
  }


  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login / Sign up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    _login(context, username, password);
                  },
                  child: Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    _register(context, username, password);
                  },
                  child: Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}