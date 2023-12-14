import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  final _mybox = Hive.box('testBox');

  List todoList = [];

  // initial data
  void createInitialData() {
    todoList = [
      ['Learn Flutter', false],
      ['Do excercise', false]
    ];
  }

  void loadData() {
    todoList = _mybox.get("todolist");
  }

  void updateDatabase() {
    _mybox.put("todolist", todoList);
    print(_mybox.get("todolist"));
  }
}
