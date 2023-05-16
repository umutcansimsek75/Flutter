import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/todo.dart';

class TodoDetail extends StatefulWidget {
  const TodoDetail({super.key});
  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  @override
  Widget build(BuildContext context) {
    Todo todo = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("${todo.title} detay"),
        actions: const [],
      ),
      body: const Center(
        child: Text("Başlık"),
      ),
    );
  }
}