import 'package:sqflite/sqflite.dart';

import '/app/utils/table_helper.dart';

import '/app/data/model/campaign/campaign_data.dart';

class CampaignsTable extends TableHelper {
  CampaignsTable(super.tableName);

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

  Future<void> campaignsDataInsert(List<CampaignData> data) async {
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

  Future<List<CampaignData>> getCampaignListData() async {
    List<Map<String, dynamic>> result = await database.query(
      tableName,
    );

    return result.map((e) => CampaignData.fromJson(e)).toList();
  }

  Future<String> getCampaignName({
    required String customerId,
    required String campaignKey,
  }) async {
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      where: 'customer_id = ? AND campaign_key = ?',
      whereArgs: [customerId, campaignKey],
      limit: 1,
    );

    return result.isNotEmpty ? result.first['campaign_name'] : '';
  }
}
