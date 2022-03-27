import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/firebaseutil.dart';
import 'package:todoapp/screens/model/task.dart';
import 'package:todoapp/screens/tasks/taskeit.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task, {Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
     
    return Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            deletTask(widget.task);
          },
          backgroundColor: Theme.of(context).colorScheme.error,
          icon: Icons.delete,
        )
      ]),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, TaskEdit.routename,arguments: Editargs(id: widget.task.id) );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                width: 2,
                height: 80,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.task.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.task.desc,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              )),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).primaryColor),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
