import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';
import '../cofig/sql_config.dart';
import '../utils/sql_tool.dart';
import '../utils/sql_utils.dart';
import '../utils/utils_tool.dart';

class UserSqlDao {
  // 单例方法
  static UserSqlDao? _dioInstance;

  static UserSqlDao instance() {
    _dioInstance ??= UserSqlDao();
    return _dioInstance!;
  }

  queryListData({
    required int page,
  }) async {
    SqlUtils sqlUtils = SqlUtils();
    List<User> list = [];
    List<User> info = await loadsqllist(sqlUtils: sqlUtils, page: page);
    list.addAll(info);
    sqlUtils.close();
    return list;
  }

  queryAUser({
    required String userName,
  }) async {
    SqlUtils sqlUtils = SqlUtils();
    var map = await queryUser(sqlUtils: sqlUtils, userName: userName);
    sqlUtils.close();
    return map;
  }


  queryUserForUserId({
    required int userId,
  }) async {
    SqlUtils sqlUtils = SqlUtils();
    var map = await queryUserId(sqlUtils: sqlUtils, userId: userId);
    sqlUtils.close();
    return map;
  }



  queryIUser({
    required String key,
  }) async {
    SqlUtils sqlUtils = SqlUtils();
    var map = await queryLikeUser(sqlUtils: sqlUtils, key: key);
    sqlUtils.close();
    return map;
  }

  queryAllUser() async {
    SqlUtils sqlUtils = SqlUtils();
    await sqlUtils.open();
    return await sqlUtils.queryList(
      sql: 'select * from ${SqlConfig.tableUse}',
    );
  }

  /// 更新书记
  updateData({required User user}) async {
    SqlUtils sqlUtils = SqlUtils();
    Map<String, Object?> par = user.toMap();
    await sqlUtils.open();
    int type = await sqlUtils.updateByHelper(
        tableName: SqlConfig.tableUse,
        setArgs: par,
        whereStr: '${UserTableField.userId} = ?',
        whereArgs: [user.userId]);
    await sqlUtils.close();
    String str = "更新成功";
    if (type != 1) {
      str = "更新失败";
    }
    showToastMsg(msg: str);
    return type;
  }

  /// 新增数据
  addData({required User user}) async {
    SqlUtils sqlUtils = SqlUtils();
    await sqlUtils.open();
    var sq = await sqlUtils.queryListByHelper(
      tableName: SqlConfig.tableUse,
      selects: [
        UserTableField.userNub,
        UserTableField.userId,
        UserTableField.phone
      ],
      whereStr: '${UserTableField.userNub} = ? or ${UserTableField.phone} = ? ',
      whereArgs: [user.userNub, user.phone],
    );

    bool yorn = false;
    String str = "添加失败";
    if (sq.isEmpty) {
      yorn = await inserData(sqlUtils: sqlUtils, user: user);
      await sqlUtils.close();
      if (!yorn) {
        str = "添加失败";
      } else {
        str = "添加成功";
      }
    } else {
      str = "用户已经存在";
    }

    showToastMsg(
        msg: str,
        ontap: () {
          if (yorn) {
            // currentGoback(Get.context!, info: {"rl": "1"});
          }
        });
    return yorn;
  }

  /// 删除数据
  delectData({
    required int userId,
  }) async {
    SqlUtils sqlUtils = SqlUtils();
    bool yorn = await delectpublish(sqlUtils: sqlUtils, userId: userId);
    sqlUtils.close();
    return yorn;
  }
}
