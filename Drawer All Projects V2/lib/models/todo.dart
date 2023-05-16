class Todo {
  int id;
  String title;
  bool isComplated;
  bool? isStar;
  Todo(
      {required this.id,
      required this.title,
      required this.isComplated,
      this.isStar = false});
}