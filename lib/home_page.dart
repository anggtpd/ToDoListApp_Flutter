import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_app/database.dart';
import 'package:to_do_list_app/dialog_box.dart';
import 'package:to_do_list_app/todo_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ToDoDatabase db = ToDoDatabase();
  final _controller = TextEditingController();

  String taskUpdated = "";
  final _mybox = Hive.box('testBox');

  @override
  void initState() {
    if (_mybox.get("todolist") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // checkbox was tapped
  void checkBox(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  // add the task to the list
  void addTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            text: "Create a new task",
            textOnPressed: "Add",
            controller: _controller,
            onPressed: addTask,
            onCancel: Navigator.of(context).pop,
          );
        });
  }

  // delete task from the list
  void deleteFunction(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  // edit task
  void editFunction(int index) {
    final controllerEdit = TextEditingController(text: db.todoList[index][0]);
    showDialog(
      context: context,
      builder: ((context) {
        return DialogBox(
            controller: controllerEdit,
            text: "Edit my task",
            textOnPressed: "Save",
            onPressed: () {
              setState(() {
                db.todoList[index][0] = controllerEdit.text;
              });
              _controller.clear();
              Navigator.of(context).pop();
              db.updateDatabase();
            },
            onCancel: Navigator.of(context).pop);
      }),
    );
  }

  // save edited task
  // void saveEditedTask(int index) {
  //   setState(() {
  //     db.todoList[index][0] = controllerEdit.text;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade400,
      appBar: AppBar(
          title: const Text(
            "To Do List App",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange),
      body: Center(
        child: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBox(value, index),
              taskDelete: (value) => deleteFunction(index),
              taskEdit: (value) => editFunction(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
