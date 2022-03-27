import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/firebaseutil.dart';
import 'package:todoapp/screens/model/task.dart';
import 'package:todoapp/screens/tasks/task_widget.dart';

class TasksTab extends StatefulWidget {
  TasksTab({Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  List<Task> tasks = [];

  DateTime dateSelect = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        CalendarTimeline(
          initialDate: dateSelect,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {

            dateSelect = date??DateTime.now();
            setState(() {
              
            });          },
          leftMargin: 20,
          monthColor: Colors.black,
          dayColor: Colors.black,
          activeDayColor: Theme.of(context).primaryColor,
          activeBackgroundDayColor: Colors.white,
          dotsColor: Color(0xFF333A47),
          // selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
                stream: listenTasks(dateSelect),
                builder: (buildContext, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasError) {
                    return Text("Something wrong !!!");
                  }

                  List<Task> taskslist =
                      snapshot.data!.docs.map((e) => e.data()).toList();
                  return ListView.builder(
                    itemCount: taskslist.length,
                    itemBuilder: (context, index) {
                      return TaskWidget(taskslist[index]);
                    },
                  );
                }))
      ]),
    );
  }
}
