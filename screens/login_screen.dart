import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/user_model.dart';


class LoginScreen extends StatefulWidget {
  final Function(User) onLogin;
  const LoginScreen({required this.onLogin});

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
      final user = User(username: username, password: password);
      print(user.getMoney());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User Logged in successfully')),
      );
      widget.onLogin(user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wrong username or password')),
      );
    }
  }

  Future<void> _register(String username, String password) async {
    final userExists = await _checkUserExists(username, password);
    if (userExists) {
      final user = User(username: username, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You already signed up')),
      );
      widget.onLogin(user);
    } else {
      final user = User(username: username, password: password);
      await _databaseService.createUser(user);
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
                    _login(username, password);
                  },
                  child: Text('Login'),
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
    );
  }
}