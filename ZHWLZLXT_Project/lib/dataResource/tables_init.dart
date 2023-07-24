import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';

import '../cofig/sql_config.dart';

class NormalCreateTables {
  static final String createUseTable = '''
    ${SqlConfig.creattable} ${SqlConfig.tableUse} (
    ${UserTableField.userId} ${SqlConfig.primarykeyauto},
    ${UserTableField.userName} ${SqlConfig.sqltext},
    ${UserTableField.account} ${SqlConfig.sqltext},
    ${UserTableField.pssWord} ${SqlConfig.sqltext},
    ${UserTableField.age} INT,
    ${UserTableField.userNub} ${SqlConfig.sqltext},
    ${UserTableField.sex} INT,
    ${UserTableField.phone} ${SqlConfig.sqltext},
    ${UserTableField.idCard} ${SqlConfig.sqltext},
    ${UserTableField.ad} ${SqlConfig.sqltext},
    ${UserTableField.bedNumber} ${SqlConfig.sqltext})
    ''';

  /// 获取所有的表
  Map<String, String> getAllTables() {
    Map<String, String> map = <String, String>{};
    map['use'] = createUseTable;
    return map;
  }
}

class TablesInit {
  static Database? db;

  Future init() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, SqlConfig.dbname);
    debugPrint('数据库存储路径path:' + path);
    NormalCreateTables sqlTables = NormalCreateTables();
    Map<String, String> allTableSqls = sqlTables.getAllTables();
    try {
      db = await openDatabase(path);
    } catch (e) {
      debugPrint('CreateTables init Error $e');
    }
    List<String> noCreateTables = await getNoCreateTables(allTableSqls);
    debugPrint('noCreateTables:' + noCreateTables.toString());
    if (noCreateTables.isNotEmpty) {
      //创建新表
      // 关闭上面打开的db，否则无法执行open
      db!.close();
      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            debugPrint('db created version is $version');
          }, onOpen: (Database db) async {
            for (var sql in noCreateTables) {
              await db.execute(allTableSqls[sql]!);
            }
            debugPrint('db补完表已打开');
          });
    } else {
      debugPrint("表都存在，db已打开");
    }
    List tableMaps = await db!
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    db!.close();
  }

  // 检查数据库中是否有所有有表,返回需要创建的表
  Future<List<String>> getNoCreateTables(Map<String, String> tableSqls) async {
    Iterable<String> tableNames = tableSqls.keys;
    //已经存在的表
    List<String> existingTables = [];
    //要创建的表
    List<String> createTables = [];
    List tableMaps = await db!
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    for (var item in tableMaps) {
      existingTables.add(item['name']);
    }
    for (var tableName in tableNames) {
      if (!existingTables.contains(tableName)) {
        createTables.add(tableName);
      }
    }
    return createTables;
  }
}
