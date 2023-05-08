import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'screens/nalan.dart';
import 'screens/calculator.dart';
import 'screens/todolist_mysql.dart';
import 'screens/todolist.dart';
import 'screens/ortalamatik.dart';
import 'utils/drawer.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoList',
      theme: ThemeData(primarySwatch: Colors.cyan),
      
      routes: {
        "/": (context) => const TodoList(),
        "/todolist_mysql": (context) => const TodoListMysql(),
        "/todolist": (context) => const TodoList(),
        "/ortalamatik": (context) => const Ortalamatik(),
        "/calculator": (context) => const Calculator(),
        "/nalan": (context) => const Nalan(),
      
      },
    );
  }
}