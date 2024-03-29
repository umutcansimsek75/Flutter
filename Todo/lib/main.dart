import 'package:flutter/material.dart';

import 'package:todo/screens/todolist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '943-Umut Can Şimşek',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const TodoList(),
    );
  }
}
