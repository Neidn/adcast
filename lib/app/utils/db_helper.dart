import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '/app/utils/global_variables.dart';

class DBHelper {
  static Database? _database;

  get database => _database;

  Future<void> init() async {
    if (_database != null) return;
    _database = await _initDB();
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), appDatabaseName);

    return await openDatabase(
      path,
      version: appDatabaseVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    // Create tables
    for (var table in appDatabaseTable.entries) {
      Map<String, String> columns = table.value;
      String query = '''
      CREATE TABLE IF NOT EXISTS ${table.key} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ${columns.entries.map((e) => '${e.key} ${e.value}').join(', ')}
      )
      ''';
      await db.execute(query);
    }

    // Create Indexes
    for (var index in appDatabaseIndexes.entries) {
      for (var column in index.value) {
        String query = '''
        CREATE INDEX IF NOT EXISTS ${index.key}_${column}_index ON ${index.key} ($column)
        ''';
        await db.execute(query);
      }
    }
  }
}
