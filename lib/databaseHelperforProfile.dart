import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, instantiate it and initialize the database
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'your_database_name.db');

    // Open/create the database at a given path
    return await openDatabase(path, version: 3, onCreate: (Database db, int version) async {
      // Create your table here
      await db.execute('''
      CREATE TABLE profile_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image BLOB
      )
    ''');
    });
  }

  static Future<void> saveProfileImage(Uint8List image) async {
    try {
      Database db = await database;
      await db.insert('profile_images', {'image': image});
    } catch (e) {
      print('Error saving profile image: $e');
      // Handle errors here, e.g., show an error dialog
    }
  }

  static Future<void> deleteProfileImage() async {
    try {
      Database db = await database;
      await db.delete('profile_images');
    } catch (e) {
      print('Error deleting profile image from the database: $e');
      // Handle errors here, e.g., show an error dialog
    }
  }
}
