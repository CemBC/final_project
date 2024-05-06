  import 'dart:async';
  import 'package:path/path.dart';
  import 'package:final_project/final_project/models/user_model.dart';
  import 'package:sqflite/sqflite.dart';

  class DatabaseService {
    static final DatabaseService _databaseService = DatabaseService._internal();
    factory DatabaseService() => _databaseService;
    DatabaseService._internal();

    static Database? _database;

    Future<Database> get database async {
      _database ??= await _initDatabase();
      return _database!;
    }

    Future<Database> _initDatabase() async {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, 'user.db');

      return await openDatabase(
        path,
        onCreate: _onCreate,
        version: 1,
      );
    }


    Future<void> _onCreate(Database db, int version) async {
      await db.execute("CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT , username TEXT , password TEXT)"
      );
    }


    Future<int> createUser(User user) async {
      final Database db = await _initDatabase();
      return db.insert('users' , user.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    Future<List<User>> users() async {
      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query('user');
      return List.generate(maps.length, (index) => User.fromJson(maps[index]));
    }

    Future<bool> isExist(String username, String password) async {
      final db = await _databaseService.database;
      final List<Map<String, dynamic>> result = await db.query('user', where: 'username = ? AND password = ?',
          whereArgs: [username, password]);
      return result.isNotEmpty;
    }

  }