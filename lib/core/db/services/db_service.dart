import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../providers/recipe_db.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      return _database!;
    } else {
      _database = await _initialize();
      return _database!;
    }
  }

  Future<String> get fullPath async {
    const name = 'recipe.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<void> create(Database database, int version) async {
    return await RecipeDB().createTable(database);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }
}
