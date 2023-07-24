/*
 * @Descripttion: 
 * @version: 
 * @Author: TT
 * @Date: 2022-08-15 15:32:57
 * @LastEditors: TT
 * @LastEditTime: 2022-08-16 11:57:19
 */

import 'package:zhwlzlxt_project/entity/user_entity.dart';
import 'package:zhwlzlxt_project/utils/sql_utils.dart';

import '../cofig/sql_config.dart';

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

/// 调用样例：await dbUtil.queryListByHelper('relation', ['id','uid','fuid'], 'uid=? and fuid=?', [6,1]);
queryUser({
  required SqlUtils sqlUtils,
  required String userName,
}) async {
  await sqlUtils.open();
  return await sqlUtils.queryListByHelper(
    tableName: SqlConfig.tableUse,
    selects: [UserTableField.userName,UserTableField.userId,UserTableField.age],
    whereStr: '${UserTableField.userName} = ?',
    whereArgs: [userName],
  );
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
