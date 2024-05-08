  import 'dart:async';
  import 'dart:convert';
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
      await db.execute("CREATE TABLE user (username TEXT PRIMARY KEY , password TEXT , money TEXT DEFAULT '{\"USD\": 0, \"EUR\": 0, \"JPY\": 0, \"GBP\": 0, \"AUD\": 0, \"TRY\": 100}' )"
      );
    }


    Future<int> createUser(User user) async {
      final Database db = await _initDatabase();
      final Map<String, dynamic> userData = {
        'username': user.username,
        'password': user.password,
        'money': user.money,
      };
      return db.insert('user', userData, conflictAlgorithm: ConflictAlgorithm.ignore);
    }

    Future<List<User>> users() async {  //for controls
      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query('user');
      return List.generate(maps.length, (index) => User.fromJson(maps[index]));
    }

    Future<Map<String, int>?> getMoney(String username) async { //for controls
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('user', where: 'username = ?', whereArgs: [username]);

      if (maps.isNotEmpty) {
        final user = User.fromJson(maps.first);
        return user.money;
      } else {
        return null;
      }
    }



    Future<bool> isExist(String username, String password) async {
      final db = await _databaseService.database;
      final List<Map<String, dynamic>> result = await db.query('user', where: 'username = ? AND password = ?',
          whereArgs: [username, password]);
      return result.isNotEmpty;
    }

    Future<void> updateUser(User user) async {  //still does not work!!
      final db = await _databaseService.database;
      await db.update(
        'user',
        {
          'money': jsonEncode(user.money),
        },
        where: 'username = ? AND password = ?',
        whereArgs: [user.username , user.password],
      );
    }

    

  }