import '/app/utils/table_helper.dart';

import '/app/data/model/user/user_info_data.dart';

class UserInfoTable extends TableHelper {
  UserInfoTable(super.tableName);

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

  Future<int> userInfoInsert(UserInfoData userInfoData) async {
    await database.delete(tableName);

    return await database.insert(tableName, userInfoData.toJson());
  }

  Future<UserInfoData> userInfoSelectOne() async {
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      limit: 1,
    );

    if (result.isEmpty) return UserInfoData();

    return UserInfoData.fromJson(result.first);
  }

  Future<String> getCustomerKey() async {
    UserInfoData userInfoData = await userInfoSelectOne();

    return userInfoData.customerKey ?? '';
  }

  Future<String> getUserId() async {
    return await userInfoSelectOne().then((value) => value.userId ?? '');
  }

  Future<String> getUserName() async {
    return await userInfoSelectOne().then((value) => value.userName ?? '');
  }

  Future<String> getUserStatus() async {
    return await userInfoSelectOne().then((value) => value.userStatus ?? '');
  }
}
