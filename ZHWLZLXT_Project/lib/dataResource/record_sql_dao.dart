import 'dart:core';

import '../cofig/sql_config.dart';
import '../entity/record_entity.dart';
import '../utils/sql_tool.dart';
import '../utils/sql_utils.dart';
import '../utils/utils_tool.dart';

class RecordSqlDao {
  static RecordSqlDao? _dioInstance;

  static RecordSqlDao instance() {
    _dioInstance ??= RecordSqlDao();
    return _dioInstance!;
  }

  /// 新增数据
  addData({required Record record}) async {
    SqlUtils sqlUtils = SqlUtils();
    await sqlUtils.open();

    Map<String, Object?> par = record.toMap();
    await sqlUtils.open();
    var yorn = await insertRecordData(sqlUtils: sqlUtils, record: record);

    await sqlUtils.close();

    String str;

    if (!yorn) {
      str = "添加失败";
    } else {
      str = "添加成功";
    }

    // showToastMsg(
    //     msg: str,
    //     ontap: () {
    //       if (yorn) {
    //       }
    //     });
  }


  queryRecordForUserId({
    required int userId,
  }) async {
    SqlUtils sqlUtils = SqlUtils();
    var map = await queryRecordUserId(sqlUtils: sqlUtils, userId: userId);
    sqlUtils.close();
    return map;
  }




  //select * from 表名

  queryAllRecord({
    required SqlUtils sqlUtils,
  }) async {
    await sqlUtils.open();
    return await sqlUtils.queryList(
      sql: 'select * from ${SqlConfig.tableRecord}',
      // tableName: SqlConfig.tableRecord,
      // selects: [
      //   RecordField.recordId,
      //   RecordField.recordType,
      //   RecordField.pattern,
      //   RecordField.power,
      //   RecordField.soundIntensity,
      //   RecordField.frequency,
      //   RecordField.dataTime,
      //   RecordField.utilityTime,
      // ],
      // whereStr: '',
      // whereArgs: [],
    );
  }
}
