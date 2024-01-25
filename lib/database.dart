import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "HistoryDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'history';

  static final columnId = '_id';
  static final columnName = 'userInput';
  static final columnImagePath = 'imagePath';
  static final columnMachineResponse = 'machineResponse';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnImagePath TEXT NOT NULL,
            $columnMachineResponse TEXT NOT NULL
          )
          ''');
  }

  // Insert a history entry into the database
  Future<int> insertHistory({
    required String userInput,
    required String imagePath,
    required String machineResponse,
  }) async {
    Database? db = await instance.database;
    if (db == null) {
      // Handle the case where the database is not open
      return -1;
    }

    Map<String, dynamic> row = {
      columnName: userInput,
      columnImagePath: imagePath,
      columnMachineResponse: machineResponse,
    };
    return await db.insert(table, row);
  }

  // Query all rows in the database
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    if (db == null) {
      // Handle the case where the database is not open
      return [];
    }

    return await db.query(table);
  }
}
