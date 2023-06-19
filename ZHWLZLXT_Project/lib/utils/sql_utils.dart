
import 'package:hzy_normal_widget/hzy_normal_widget.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../cofig/sql_config.dart';


/// 数据库 工具类
class SqlUtils {
  Database? db;

  ///sql助手插入 @tableName:表名  @paramters：参数map
  /// eg:
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// await sqlUtils.insertByHelper(SqlConfig.list, {"uid":uid,"name":name});
  Future<int> insertByHelper({
    required String tableName,
    required Map<String, dynamic> paramters,
  }) async {
    return await db!.insert(
      tableName,
      paramters,
    );
  }

  /// sql原生插入
  /// eg:
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// await sqlUtils.insert('INSERT INTO List(name, value) VALUES(?, ?)',['name', 'name']);
  Future<int> insert({
    required String sql,
    required List paramters,
  }) async {
    return await db!.rawInsert(
      sql,
      paramters,
    );
  }

  /// sql助手查找列表  @tableName:表名  @selects 查询的字段数组 @wheres 条件，如：'uid=? and fuid=?' @whereArgs 参数数组
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// List list = await sqlUtils.queryListByHelper(
  ///    SqlConfig.list,
  ///    ['uid'],
  ///    'uid = ?',
  ///    [1]);
  Future<List<Map>> queryListByHelper({
    required String tableName,
    required List<String> selects,
    required String whereStr,
    required List whereArgs,
  }) async {
    List<Map> maps = await db!.query(
      tableName,
      columns: selects,
      where: whereStr,
      whereArgs: whereArgs,
    );
    return maps;
  }

  /// sql 分页查询
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// List list = await sqlUtils.queryListforpageHelper(
  ///    ['uid'],  查询返回的数据字段
  ///    'uid = ?', 查询字段
  ///    [1], 对应的查询条件
  ///    page, 当前页数
  ///    10, 每页个数
  ///    orderBy: "createTime DESC" 根据对应字段进行排序 DESC 从大到小排序 ---降序排列 ASC 从小到大排序 -- 升序排列
  ///
  /// );
  Future<List<Map>> queryListforpageHelper({
    required String tableName,
    required List<String> selects,
    required String whereStr,
    required List whereArgs,
    required int page,
    required int size,
    String? orderBy,
  }) async {
    List<Map> maps = await db!.query(
      tableName,
      columns: selects,
      where: whereStr,
      whereArgs: whereArgs,
      limit: size,
      offset: (page - 1) * size,
      orderBy: orderBy,
    );
    return maps;
  }

  /// sql原生查找列表
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// await sqlUtils.queryList(
  ///    "select * from ${SqlConfig.list} where ${uid} = '$userId'"
  /// );
  Future<List<Map>> queryList({
    required String sql,
  }) async {
    return await db!.rawQuery(sql);
  }

  /// sql助手更新数据
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// await sqlUtils.updateByHelper(SqlConfig.list, par,
  /// "${UsermodelStrId.account} = ?", [usermodel.account]);
  Future<int> updateByHelper({
    /// 表名
    required String tableName,

    /// 需要修改的数据
    required Map<String, Object?> setArgs,

    /// 根据条件，获取需要修改数据
    required String whereStr,

    /// 条件
    required List whereArgs,
  }) async {
    return await db!.update(
      tableName,
      setArgs,
      where: whereStr,
      whereArgs: whereArgs,
    );
  }

  ///sql原生修改
  Future<int> update({
    required String sql,
    required List paramters,
  }) async {
    //样例：dbUtil.update('UPDATE relation SET fuid = ?, type = ? WHERE uid = ?', [1,2,3]);
    return await db!.rawUpdate(
      sql,
      paramters,
    );
  }

  ///sql助手删除   刪除全部whereStr和whereArgs传null
  Future<int> deleteByHelper({
    required String tableName,
    required String whereStr,
    required List whereArgs,
  }) async {
    return await db!.delete(
      tableName,
      where: whereStr,
      whereArgs: whereArgs,
    );
  }

  ///sql原生删除
  Future<int> delete({
    required String sql,
    required List parameters,
  }) async {
    //样例： 样例：await dbUtil.delete('DELETE FROM relation WHERE uid = ? and fuid = ?', [123,234]);
    return await db!.rawDelete(
      sql,
      parameters,
    );
  }

  //清空数据
  Future<int> clear({
    required String tableName,
  }) async {
    return await db!.delete(tableName);
  }

  ///获取Batch对象，用于执行sql批处理
  Future<Batch> getBatch() async {
    //调用样例
    //  Batch batch = await DBUtil().getBatch();
    //  batch.insert('Test', {'name': 'item'});
    //  batch.update('Test', {'name': 'new_item'}, where: 'name = ?', whereArgs: ['item']);
    //  batch.delete('Test', where: 'name = ?', whereArgs: ['item']);
    //  List<Object> results = await batch.commit();  //返回的是id数组
    //                         //batch.commit(noResult: true);//noResult: true不关心返回结果，性能高
    //                         //batch.commit(continueOnError: true)//continueOnError: true  忽略错误，错误可继续执行
    return db!.batch();
  }

  ///事务控制
  Future<dynamic> transaction(
      Future<dynamic> Function(Transaction txn) action) async {
    //调用样例
    //  try {
    //     await dbUtil.transaction((txn) async {
    //        Map<String,Object> par = Map<String,Object>();
    //        par['uid'] = Random().nextInt(10); par['fuid'] = Random().nextInt(10);
    //        par['type'] = Random().nextInt(2); par['id'] = 1;
    //        var a = await txn.insert('relation', par);
    //        var b = await txn.insert('relation', par);
    //   });
    //   } catch (e) {
    //     debugprint('sql异常:$e');
    //   }
    return await db!.transaction(action);
  }

  //打开DB
  open() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, SqlConfig.dbname);
    debugprint('数据库存储路径path:' + path);
    try {
      db = await openDatabase(path);
    } catch (e) {
      debugprint('DBUtil open() Error $e');
    }
  }

  // 记得及时关闭数据库，防止内存泄漏
  close() async {
    await db!.close();
  }
}
