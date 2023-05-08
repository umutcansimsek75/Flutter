import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:myapp/screens/todoDatabase.dart';
import 'package:myapp/utils/drawer.dart';

import '../models/todo.dart';

class TodoListMysql extends StatefulWidget {
  const TodoListMysql({Key? key}) : super(key: key);

  @override
  State<TodoListMysql> createState() => _TodoListMysqlState();
}

class _TodoListMysqlState extends State<TodoListMysql> {
  List<Todo> todolist = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title = "";
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isObscure = true;

  @override
  void initState() {
    mysqlconn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          addTodo();
        },
      ),
      drawer: MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("TodoList-Mysql/Umut Can Şimşek"),
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
              color: Colors.grey[300],
              child: Form(
                autovalidateMode: autovalidateMode,
                key: formKey,
                child: TextFormField(
                  obscureText: isObscure,
                  maxLines: 1,
                  onSaved: (newValue) {
                    title = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Boş geçilemez';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Başlık',
                      labelText: 'Başlık Giriniz.',
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        child: Icon(isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: todolist.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo item = todolist[index];
                  return ListTile(
                    tileColor: item.isComplated ? Colors.green : Colors.red,
                    title: Text(
                      "#${item.id} - ${item.title}",
                      style: TextStyle(
                        decoration: item.isComplated
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: InkWell(
                      child: const Text("Bilgi Giriniz."),
                      onTap: () {
                        setState(() {
                          item.isComplated = !item.isComplated;
                          updateIsComplated(item);
                        });
                      },
                    ),
                    leading: item.isComplated
                        ? const Icon(Icons.check_box_outlined)
                        : const Icon(Icons.check_box_outline_blank),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              item.isStar = !item.isStar!;
                            });
                          },
                          icon: Icon(
                            Icons.star,
                            color: item.isStar! ? Colors.amber : Colors.black45,
                          ),
                        ),
                        InkWell(
                            child: const Icon(Icons.close),
                            onTap: () async {
                              setState(() {
                                todolist.removeAt(index);
                                deleteTodo(item.id);
                              });
                            })
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void addTodo() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      alertSuccess("Kayıt Eklendi!");
      final conn = await TodoDatabase.mysqlConn();
      await conn.query(
          'insert into todo (title, iscomplated, isStar) values (?, ?,?)',
          [title, false, false]);
      var results = await conn.query("select * from todo");
      setState(() {
        todolist = [];
        for (var element in results) {
          todolist.add(Todo(
              id: element["id"],
              title: element["title"],
              isComplated: element["iscomplated"] == 1 ? true : false));
        }
      });
      debugPrint(todolist.toString());
      formKey.currentState!.reset();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void updateIsComplated(Todo todo) async {
    final conn = await TodoDatabase.mysqlConn();
    await conn.query('update todo set iscomplated=? where id=?',
        [!todo.isComplated, todo.id]);
  }

  void updateIsStar(Todo todo) async {
    final conn = await TodoDatabase.mysqlConn();
    await conn
        .query('update todo set isStar=? where id=?', [!todo.isStar!, todo.id]);
  }

  void deleteTodo(int id) async {
    final conn = await TodoDatabase.mysqlConn();
    await conn.query('delete from todo where id = ?', [id]);
  }

  void mysqlconn() async {
    debugPrint("Bağlanıldı");
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'db4free.net',
        port: 3306,
        user: 'launcher_d_admin',
        db: 'deneme_launcher',
        password: '123456789a'));
    var results = await conn.query("select * from todo");
    debugPrint(results.toString());

    setState(() {
      todolist = [];
      for (var element in results) {
        todolist.add(Todo(
            id: element["id"],
            title: element["title"],
            isComplated: element["iscomplated"] == 1 ? true : false));
      }
    });
  }

  void alertSuccess(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Kapat"),
                ),
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