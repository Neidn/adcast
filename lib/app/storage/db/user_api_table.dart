import 'package:adcast/app/data/model/user/user_api_data.dart';
import 'package:adcast/app/utils/table_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserApiTable extends TableHelper {
  UserApiTable(super.tableName);

  @override
  Future<void> delete(Map<String, dynamic> data) async {
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  @override
  Future<void> update(Map<String, dynamic> data) async {
    await database.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> select(Map<String, dynamic> data) async {
    return await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<void> userApiInsertAll(List<UserApiData> data) async {
    await database.delete(tableName);

    await database.transaction((txn) async {
      Batch batch = txn.batch();
      for (var element in data) {
        batch.insert(
          tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }

  Future<List<UserApiData>> getUserApiListData() async {
    List<Map<String, dynamic>> result = await database.query(
      tableName,
    );
    return result.map((e) => UserApiData.fromJson(e)).toList();
  }

  Future<String> getCustomerName({required String customerId}) async {
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      where: 'customer_id = ?',
      whereArgs: [customerId],
      limit: 1,
    );

    return result.isNotEmpty ? result.first['customer_name'] : '';
  }
}
