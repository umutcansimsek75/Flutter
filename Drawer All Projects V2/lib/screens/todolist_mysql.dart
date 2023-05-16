import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:myapp/screens/todoDatabase.dart';
import 'package:myapp/screens/tododetail.dart';
import 'package:myapp/utils/drawer.dart';
import 'package:get/get.dart';
import '../models/todo.dart';

class TodoListMysql extends StatefulWidget {
  const TodoListMysql({Key? key}) : super(key: key);

  @override
  State<TodoListMysql> createState() => _TodoListMysqlState();
}

final conn = MySqlConnection.connect(
  ConnectionSettings(
      host: '93.89.225.127',
      port: 3306,
      user: 'ideftp1_testus',
      db: 'ideftp1_testdb',
      password: '123456aA+-'),
);

class _TodoListMysqlState extends State<TodoListMysql> {
  List<Todo> todolist = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title = "";
  late Todo editableTodo;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController titleController = TextEditingController();
  bool isObscure = false;
  bool isEdit = false;

  @override
  void initState() {
    mysqlconn();
    super.initState();
  }

  @override
  void dispose() {
    conn.ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isEdit ? Icons.save : Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          isEdit ? updateTodo() : addTodo();
          setState(() {
            isEdit = false;
          });
        },
      ),
      drawer: MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("TodoList-DB"),
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            color: Colors.grey[300],
            child: Form(
              autovalidateMode: autovalidateMode,
              key: formKey,
              child: TextFormField(
                controller: titleController,
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
                      child: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility),
                    )),
              ),
            ),
          ),
          Expanded(
            flex: 3,
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
                              print("gbhh");
                              isEdit = !isEdit;
                              editableTodo = item;
                              if (isEdit) {
                                titleController.text = item.title;
                              } else {
                                titleController.text = "";
                              }
                            });
                            updateIsStar(item);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: isEdit && editableTodo == item
                                ? Colors.blue
                                : Colors.black45,
                          )),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            item.isStar = !item.isStar!;
                            updateIsStar(item);
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
                          }),
                      IconButton(
                          onPressed: () {
                            Get.to(TodoDetail(), arguments: item);
                          },
                          icon: Icon(Icons.arrow_forward_ios_sharp)),
                      InkWell(onTap: () async {
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

  Future updateTodo() async {
    final conn = await TodoDatabase.mysqlConn();
    await conn.query('update todo set title=? where id=?',
        [titleController.text, editableTodo.id]);

    todolist
        .map((e) => {
              if (e == editableTodo)
                {
                  setState(() {
                    e.title = titleController.text;
                  })
                }
            })
        .toList();
  }

  Future updateIsComplated(Todo todo) async {
    final conn = await TodoDatabase.mysqlConn();
    await conn.query('update todo set iscomplated=? where id=?',
        [todo.isComplated, todo.id]);
  }

  Future updateIsStar(Todo todo) async {
    final conn = await TodoDatabase.mysqlConn();
    await conn
        .query('update todo set isStar=? where id=?', [todo.isStar!, todo.id]);
  }

  Future deleteTodo(int id) async {
    final conn = await TodoDatabase.mysqlConn();
    await conn.query('delete from todo where id = ?', [id]);
  }

  void mysqlconn() async {
    var connUrl = await conn;
    debugPrint("Bağlanıldı");
    var results = await connUrl.query("select * from todo");
    debugPrint(results.toString());

    setState(() {
      todolist = [];
      for (var element in results) {
        todolist.add(Todo(
          id: element["id"],
          title: element["title"],
          isComplated: element["iscomplated"] == 1 ? true : false,
          isStar: element["isstar"] == 1 ? true : false,
        ));
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