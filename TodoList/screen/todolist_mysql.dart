import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import '../models/todo.dart';

class TodoListMysql extends StatefulWidget {
  const TodoListMysql({super.key});

  @override
  State<TodoListMysql> createState() => _TodoListMysqlState();
}

class _TodoListMysqlState extends State<TodoListMysql> {
  List<Todo> MysqlTodolist = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title = "";
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

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
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[],
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("TodoList"),
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
                autovalidateMode: _autovalidateMode,
                key: formKey,
                child: TextFormField(
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
                  decoration: const InputDecoration(
                      hintText: 'Başlık', labelText: 'Başlık giriniz.'),
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
                itemCount: MysqlTodolist.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo item = MysqlTodolist[index];
                  return ListTile(
                    tileColor:
                        item.isComplated ? Colors.green[100] : Colors.red[100],
                    title: Text(
                      "#${item.id} - ${item.title}",
                      style: TextStyle(
                        decoration: item.isComplated
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: InkWell(
                      child: const Text("Tıkla ve görevi tamamla!"),
                      onTap: () {
                        setState(() {
                          item.isComplated = !item.isComplated;
                          updateTodo(item.id, item.isComplated);
                        });
                      },
                    ),
                    leading: item.isComplated
                        ? const Icon(Icons.check_box_outlined)
                        : const Icon(Icons.check_box_outline_blank),
                    trailing: InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        setState(() {
                          deleteTodo(item.id);

                          MysqlTodolist.remove(item);
                        });
                      },
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
      final conn = await MySqlConnection.connect(ConnectionSettings(
          host: '93.89.225.127',
          port: 3306,
          user: 'ideftp1_testus',
          db: 'ideftp1_testdb',
          password: '123456aA+-'));
      await conn.query('insert into todo (title, iscomplated) values (?, ?)',
          [title, false]);
      var results = await conn.query("select * from todo");
      setState(() {
        MysqlTodolist = [];
        for (var element in results) {
          MysqlTodolist.add(Todo(
              id: element["id"],
              title: element["title"],
              isComplated: element["iscomplated"] == 1 ? true : false));
        }
      });
      debugPrint(MysqlTodolist.toString());
      formKey.currentState!.reset();
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void updateTodo(int id, bool iscomplated) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '93.89.225.127',
        port: 3306,
        user: 'ideftp1_testus',
        db: 'ideftp1_testdb',
        password: '123456aA+-'));
    await conn
        .query('update todo set iscomplated=? where id=?', [iscomplated, id]);
  }

  void deleteTodo(int id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '93.89.225.127',
        port: 3306,
        user: 'ideftp1_testus',
        db: 'ideftp1_testdb',
        password: '123456aA+-'));
    await conn.query('delete from todo where id = ?', [id]);
  }

  void mysqlconn() async {
    debugPrint("Bağlanmaya çalıştı");
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '93.89.225.127',
        port: 3306,
        user: 'ideftp1_testus',
        db: 'ideftp1_testdb',
        password: '123456aA+-'));
    var results = await conn.query("select * from todo");
    debugPrint(results.toString());

    setState(() {
      MysqlTodolist = [];
      for (var element in results) {
        MysqlTodolist.add(Todo(
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
