/*
 * @Descripttion: 
 * @version: 
 * @Author: TT
 * @Date: 2022-08-15 15:32:57
 * @LastEditors: TT
 * @LastEditTime: 2022-08-16 11:57:19
 */

import 'package:common_utils/common_utils.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';
import 'package:zhwlzlxt_project/utils/sql_utils.dart';

import '../cofig/sql_config.dart';
import '../entity/record_entity.dart';

/// 获取列表数据
Future<List<User>> loadsqllist({
  required SqlUtils sqlUtils,
  required int page,
}) async {
  List<User> list = [];
  await sqlUtils.open();
  List ulist = await sqlUtils.queryListforpageHelper(
    tableName: SqlConfig.tableUse,
    selects: [
      UserTableField.userId,
      UserTableField.userName,
      UserTableField.userNub,
      UserTableField.age,
      UserTableField.account,
    ],
    whereStr: '${UserTableField.userId} = ?',
    whereArgs: [1],
    page: page,
    size: 10,
    orderBy: "${UserTableField.userId} DESC",
  );
  await sqlUtils.close();
  if (ulist.isNotEmpty) {
    for (var item in ulist) {
      User model = User.fromMap(item);
      list.add(model);
    }
  }
  return list;
}

/// 删除数据
delectpublish({
  required SqlUtils sqlUtils,
  required int userId,
}) async {
  await sqlUtils.open();
  int state = await sqlUtils.deleteByHelper(
    tableName: SqlConfig.tableUse,
    whereStr: "${UserTableField.userId} = ?",
    whereArgs: [userId],
  );
  return state != -1 ? true : false;
}

queryUser({
  required SqlUtils sqlUtils,
  required String userName,
}) async {
  await sqlUtils.open();
  return await sqlUtils.queryListByHelper(
    tableName: SqlConfig.tableUse,
    selects: [
      UserTableField.userName,
      UserTableField.userId,
      UserTableField.age
    ],
    whereStr: '${UserTableField.userName} = ?',
    whereArgs: [userName],
  );
}




queryUserId({
  required SqlUtils sqlUtils,
  required int userId,
}) async {
  await sqlUtils.open();
  return await sqlUtils.queryListByHelper(
    tableName: SqlConfig.tableUse,
    selects: [
      UserTableField.userName,
      UserTableField.phone,
      UserTableField.userId,
      UserTableField.age
    ],
    whereStr: '${UserTableField.userId} = ?',
    whereArgs: [userId],
  );
}



queryRecordUserId({
  required SqlUtils sqlUtils,
  required int userId,
}) async {
  await sqlUtils.open();
  return await sqlUtils.queryListByHelper(
    tableName: SqlConfig.tableRecord,
    selects: [
      RecordField.recordType,
      RecordField.pattern,
      RecordField.power,
      RecordField.soundIntensity,
      RecordField.frequency,
      RecordField.dataTime,
      RecordField.utilityTime,
      RecordField.zdTime,
      RecordField.widthA,
      RecordField.widthB,
      RecordField.delayTime,
      RecordField.circle,
      RecordField.strengthGrade,
      RecordField.strengthGradeA,
      RecordField.strengthGradeB,
      RecordField.actionTime
    ],
    whereStr: '${RecordField.userId} = ?',
    whereArgs: [userId],
  );
}





/// sql原生查找列表
/// SqlUtils sqlUtils = SqlUtils();
/// await sqlUtils.open();
/// await sqlUtils.queryList(
///    "select * from ${SqlConfig.list} where ${uid} = '$userId'"
/// );

queryLikeUser({
  required SqlUtils sqlUtils,
  required String key,
}) async {
  await sqlUtils.open();
  String sql =
      "select * from ${SqlConfig.tableUse} where ${UserTableField.userName} like '$key%' or ${UserTableField.phone} like '$key%' ";
  return await sqlUtils.queryList(sql: sql);

  // return await sqlUtils.queryListByHelper(
  //   tableName: SqlConfig.tableUse,
  //   selects: [UserTableField.userName, UserTableField.phone],
  //   whereStr:
  //       '${UserTableField.userName} like ? || ${UserTableField.phone} like ?',
  //   whereArgs: [key],
  // );
}

/// 插入数据
inserData({
  required SqlUtils sqlUtils,
  required User user,
}) async {
  await sqlUtils.open();
  int state = await sqlUtils.insertByHelper(
      tableName: SqlConfig.tableUse, paramters: user.toMap());
  return state != -1 ? true : false;
}

insertRecordData({
  required SqlUtils sqlUtils,
  required Record record,
}) async {
  await sqlUtils.open();
  int state = await sqlUtils.insertByHelper(
      tableName: SqlConfig.tableRecord, paramters: record.toMap());
  return state != -1 ? true : false;
}

queryAllRecord({
  required SqlUtils sqlUtils,
}) async {
  await sqlUtils.open();
  return await sqlUtils.queryListByHelper(
    tableName: SqlConfig.tableRecord,
    selects: [
      RecordField.recordId,
      RecordField.recordType,
      RecordField.pattern,
      RecordField.power,
      RecordField.soundIntensity,
      RecordField.frequency,
      RecordField.dataTime,
      RecordField.utilityTime,
    ],
    whereStr: '',
    whereArgs: [],
  );
}
