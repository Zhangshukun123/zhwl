class SqlConfig {
  /// 数据库名字
  static String dbname = "zhwl.db";

  /// 数据库表版本
  static int dbversion = 1;

  /// 创建表通用语句
  static String creattable = 'CREATE TABLE IF NOT EXISTS';

  /// 主键 递增
  static String primarykeyauto =
      'INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE';

  /// 不为null
  static String sqlnonull = 'NOT NULL';

  /// text
  static String sqltext = 'TEXT';

  /// 列表数据表名字
  static String tableUse = 'Use';

  static String tableRecord = 'Record';
}
