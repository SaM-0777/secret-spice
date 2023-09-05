import 'package:sqflite/sqflite.dart';

class RecipeDB {
  final String tableName = "recipe";

  Future<void> createTable(Database database) async {
    await database.execute(
      """
        CREATE TABLE IF NOT EXISTS $tableName (
          "id" INTEGER PRIMARY KEY NOT NULL,
          "name" TEXT NOT NULL,
          "image_url" TEXT NOT NULL,
          "description" TEXT NOT NULL,
          "cuisine" TEXT,
          "course" TEXT,
          "diet" TEXT,
        )
      """
    );
  }
}
