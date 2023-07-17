import 'package:adcast/app/data/model/payment/bank_data.dart';
import 'package:adcast/app/utils/table_helper.dart';
import 'package:sqflite/sqflite.dart';

class BankTable extends TableHelper {
  BankTable(super.tableName);

  @override
  Future<void> delete(Map<String, dynamic> data) async {
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> select(Map<String, dynamic> data) async {
    return await database.query(
      tableName,
      limit: 1,
    );
  }

  @override
  Future<void> update(Map<String, dynamic> data) async {
    await database.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> banksDataInsert(BankData data) async {
    await database.delete(tableName);

    await database.transaction((txn) async {
      Batch batch = txn.batch();
      batch.insert(
        tableName,
        data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await batch.commit(noResult: true);
    });
  }
}
