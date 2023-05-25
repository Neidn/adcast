import 'package:sqflite/sqlite_api.dart';

import '/app/utils/db_helper.dart';

abstract class TableHelper {
  final String _tableName;

  TableHelper(this._tableName) : _database = DBHelper().database as Database;

  String get tableName => _tableName;

  final Database _database;

  Database get database => _database;

  Future<void> update(Map<String, dynamic> data);

  Future<void> delete(Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> select(Map<String, dynamic> data);

  Future<int> queryRowCount() async {
    return await database.query(tableName).then((value) => value.length);
  }

  Future<List<Map<String, dynamic>>> selectAll() async {
    return await database.query(
      tableName,
    );
  }

  Future<int> insert(Map<String, dynamic> data) async {
    return await database.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteAll() async {
    await database.delete(
      tableName,
    );
  }
}
