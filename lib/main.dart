import 'package:flutter/material.dart';
import 'package:petgoapp/screen/todolist_mysql.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '943-Umut ',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const TodoListMysql(),
    );
  }
}
