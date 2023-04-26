import 'package:flutter/material.dart';
import '../models/Todo.dart';
class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  @override
  State<Todolist> createState() => _TodolistState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
late String title;
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
List<Todo> todolist = [];

class _TodolistState extends State<Todolist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Todo List/ 9174-Arda '),
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
              child: Form(
                key: formKey,
                child: TextFormField(
                  autovalidateMode: autovalidateMode,
                  onSaved: (newValue) {
                    title = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Boş geçilemez!!";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Başlık", hintText: "Başlık giriniz"),
                ),
              ),
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
                  itemCount: todolist.length,
                  itemBuilder: (BuildContext context, int index) {
                    Todo item = todolist[index];
                    return ListTile(
                      tileColor: item.isComplated
                          ? Colors.red[100]
                          : Colors.green[100],
                      title: Text(
                        "${item.id} - ${item.title}",
                        style: item.isComplated==true
                        ? const TextStyle(decoration: TextDecoration.lineThrough):const TextStyle(),
                      ),
                      subtitle: const Text("tıkla ve tamamla"),
                      leading: Checkbox(
                        activeColor: Colors.red[100],
                        checkColor: Colors.black,
                        onChanged: (value){
                          setState(() {
                            item.isComplated=value!;
                          });
                        },
                        value: item.isComplated,
                      ),
                      trailing: InkWell(
                          child: const Icon(Icons.delete),
                          onTap: () {
                            setState(() {
                              deleteTodo(item.id);
                            });//Delete
                          },
                        ),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }

  void addTodo() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        todolist.add(Todo(
            id: todolist.isNotEmpty ? todolist.last.id + 1 : 1,
            title: title,
            isComplated: false));
      });
      debugPrint(todolist.toString());
      alertSuccess();
      formKey.currentState!.reset();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  } 
  
  void deleteTodo(int id) {
    final item = todolist.firstWhere((element) => element.id == id);
    todolist.remove(item);
  }




  void alertSuccess() {
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
                        child: const Text("Kayıt Eklendi!")),
                  ],
                ),
              ),
            ));
  }
}
