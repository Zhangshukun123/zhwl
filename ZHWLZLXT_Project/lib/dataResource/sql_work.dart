import 'package:hzy_normal_widget/hzy_normal_widget.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';

import '../cofig/sql_config.dart';
import '../utils/sql_tool.dart';
import '../utils/sql_utils.dart';
import '../utils/utils_tool.dart';

class SqlWork extends BaseVM {
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

  /// 更新书记
  updateData({required User user}) async {
    SqlUtils sqlUtils = SqlUtils();
    Map<String, Object?> par = user.toMap();
    await sqlUtils.open();
    int type = await sqlUtils.updateByHelper(
        tableName: SqlConfig.tableUse,
        setArgs: par,
        whereStr: '${user.userId} = ?',
        whereArgs: [user.userId]);
    await sqlUtils.close();
    String str = "更新成功";
    if (type != 1) {
      str = "更新失败";
    }

    showToastMsg(
        msg: str,
        ontap: () {
          if (type == 1) {
            currentGoback(Get.context!, info: {"rl": "1"});
          }
        });
  }

  /// 新增数据
  addData({required User user}) async {
    SqlUtils sqlUtils = SqlUtils();
    await sqlUtils.open();
    bool yorn = await inserData(sqlUtils: sqlUtils, user: user);
    await sqlUtils.close();
    String str = "添加成功";
    if (!yorn) {
      str = "添加失败";
    }
    showToastMsg(
        msg: str,
        ontap: () {
          if (yorn) {
            currentGoback(Get.context!, info: {"rl": "1"});
          }
        });
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
