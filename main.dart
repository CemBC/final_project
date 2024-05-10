import 'package:final_project/final_project/screens/main_screen.dart';
import 'package:flutter/material.dart';
  void main() {
  runApp(MaterialApp(
    home: Scaffold(
     body: MainScreen()
    )
  ));
}

/*
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:final_project/final_project/database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Veritabanını sıfırlamak için deleteDatabase fonksiyonunu çağırın
  await resetDatabase();

  runApp(MyApp());
}

Future<void> resetDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'user.db');
  await deleteDatabase(path);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Center(
          child: Text('Welcome to my app!'),
        ),
      ),
    );
  }
} */
