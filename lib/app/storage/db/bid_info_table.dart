import 'package:adcast/app/data/model/payment/bid_data.dart';
import 'package:adcast/app/utils/table_helper.dart';
import 'package:sqflite/sqflite.dart';

class BidInfoTable extends TableHelper {
  BidInfoTable(super.tableName);

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

  Future<void> bidInfoDataInsert(BidData data) async {
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
