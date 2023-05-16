import 'package:flutter/material.dart';

import 'package:myapp/models/todo.dart';
import 'package:myapp/utils/drawer.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Todo list | Umut Can Şimşek"),
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
              color: Colors.grey[200],
              child: Form(
                  key: formKey,
                  child: TextFormField(
                    autovalidateMode: autovalidateMode,
                    onSaved: (newValue) {
                      title = newValue!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Boş geçilemez!";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: "Başlık", hintText: "Başlık giriniz"),
                  )),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        height: 5,
                        color: Colors.transparent,
                      ),
                  padding: const EdgeInsets.all(5),
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    Todo item = todoList[index];
                    return ListTile(
                      tileColor: item.isComplated
                          ? Colors.red[100]
                          : Colors.green[100],
                      title: Text(
                        "${item.id} - ${item.title}",
                        style: TextStyle(
                            decoration: item.isComplated
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      subtitle: const Text("tıkla ve tamamla"),
                      leading: Checkbox(
                        activeColor: Colors.red[100],
                        checkColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            item.isComplated = value!;
                          });
                        },
                        value: item.isComplated,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            setState((){
                            todoList.remove(item);
                            });
                          }, icon: const Icon(Icons.delete)),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  void addTodo() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        todoList.add(Todo(
            id: todoList.isNotEmpty ? todoList.last.id + 1 : 1,
            title: title,
            isComplated: false));
      });
      debugPrint(todoList.toString());
      alertSuccess("Kayıt Eklendi!");
      formKey.currentState!.reset();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void alertSuccess(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Kapat"))
              ],
              content: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 72,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(message)),
                  ],
                ),
              ),
            ));
  }
}