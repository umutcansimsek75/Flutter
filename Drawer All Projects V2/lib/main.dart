import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/home.dart';
import 'screens/nalan.dart';
import 'screens/calculator.dart';
import 'screens/todolist_mysql.dart';
import 'screens/ortalamatik.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoList',
      theme: ThemeData(primarySwatch: Colors.cyan),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/todolist_mysql": (context) => const TodoListMysql(),
        "/ortalamatik": (context) => const Ortalamatik(),
        "/calculator": (context) => const Calculator(),
        "/nalan": (context) => const Nalan(),
      },
      // home: const TodoListMysql(),
    );
  }
}