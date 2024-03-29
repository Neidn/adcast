import 'package:sqflite/sqflite.dart';

import '/app/utils/table_helper.dart';
import '/app/data/model/campaign/group_data.dart';

class GroupsTable extends TableHelper {
  GroupsTable(super.tableName);

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

  Future<void> groupsDataInsert(List<GroupData> data) async {
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

  Future<List<GroupData>> getGroupListData(String campaignKey) async {
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      where: 'campaign_key = ?',
      whereArgs: [campaignKey],
    );
    return result.map((e) => GroupData.fromJson(e)).toList();
  }

  Future<String> getGroupName({
    required String campaignKey,
    required String groupKey,
  }) async {
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      where: 'campaign_key = ? AND group_key = ?',
      whereArgs: [campaignKey, groupKey],
      limit: 1,
    );

    return result.isNotEmpty ? result.first['group_name'] : '';
  }
}
