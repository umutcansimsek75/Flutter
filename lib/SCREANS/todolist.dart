import 'dart:io';
import 'package:myapp/main.dart';

import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  final GlobalKey<FormState> formkey = GlobalKey();
  late String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: Form(
                      key: formkey,
                      child: TextFormField(validator: (value) {
                        if (value!.isEmpty) {
                          return ("Boş Geçilmesin");
                        } else {
                          return (null);
                        }
                      })))),
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topCenter,
                child: const Text("Liste"),
              ))
        ],
      ),
    );
  }
}
