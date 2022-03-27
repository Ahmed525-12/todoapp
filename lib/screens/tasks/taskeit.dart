import 'package:flutter/material.dart';

import '../../firebaseutil.dart';
import '../model/task.dart';
import '../utils/utils_ui.dart';

class TaskEdit extends StatefulWidget {
  static const String routename = "taskedit";

  TaskEdit({Key? key}) : super(key: key);

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  String title = "";

  String desc = "";
  GlobalKey<FormState> formControll = GlobalKey<FormState>();

  DateTime selectdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Task task;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formControll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            title = value;
                          },
                          decoration: InputDecoration(labelText: "Title"),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return " pelease Enter title";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            desc = value;
                          },
                          minLines: 4,
                          maxLines: 4,
                          decoration: InputDecoration(labelText: "Description"),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return " pelease Enter Description";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Date Task"),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            chooseDate();
                          },
                          child: Text(
                            "${selectdate.year} / ${selectdate.month} / ${selectdate.day}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: ElevatedButton(
                    onPressed: () {
                      addTaskid();
                    },
                    child: Text("Edit Task")),
              )
            ],
          )),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: selectdate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chooseDate != null) {
      selectdate = chooseDate;
      setState(() {});
    }
  }

  void addTaskid() {
    if (formControll.currentState?.validate() == true) {
      Task task = Task(
          title: title,
          desc: desc,
          date: DateUtils.dateOnly(selectdate).microsecondsSinceEpoch);

      showLoading("loading...", context, isCanceld: false);
      addTasksid(task);
    }
  }
}

class Editargs {
  String id;
  Editargs({required this.id});
}
