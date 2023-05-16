import 'package:mysql1/mysql1.dart';

class TodoDatabase {
  static Future<MySqlConnection> mysqlConn() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '93.89.225.127',
        port: 3306,
        user: 'ideftp1_testus',
        db: 'ideftp1_testdb',
        password: '123456aA+-'));
    return conn;
  }
}