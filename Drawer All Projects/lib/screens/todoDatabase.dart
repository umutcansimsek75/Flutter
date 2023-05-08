import 'package:mysql1/mysql1.dart';

class TodoDatabase {
  static Future<MySqlConnection> mysqlConn() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
       host: 'db4free.net',
        port: 3306,
        user: 'launcher_d_admin',
        db: 'deneme_launcher',
        password: '123456789a'));
    return conn;
  }}