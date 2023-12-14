import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? taskDelete;
  final Function(BuildContext)? taskEdit;

  const TodoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.taskDelete,
      required this.taskEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: const BehindMotion(), children: [
          SlidableAction(
            flex: 2,
            onPressed: taskEdit,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            flex: 2,
            onPressed: taskDelete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(12),
          ),
        ]),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.deepOrange,
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.white,
                checkColor: Colors.deepOrange,
                side: const BorderSide(color: Colors.white),
              ),
              Text(
                taskName,
                style: TextStyle(
                    color: Colors.white,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
