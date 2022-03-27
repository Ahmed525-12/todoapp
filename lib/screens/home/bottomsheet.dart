import 'package:flutter/material.dart';
import 'package:todoapp/firebaseutil.dart';
import 'package:todoapp/screens/model/task.dart';

import '../utils/utils_ui.dart';

class BottomSheetTab extends StatefulWidget {
  BottomSheetTab({Key? key}) : super(key: key);

  @override
  State<BottomSheetTab> createState() => _BottomSheetTabState();
}

class _BottomSheetTabState extends State<BottomSheetTab> {
  String title = "";

  String desc = "";

  DateTime selectdate = DateTime.now();

  GlobalKey<FormState> formControll = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              "Add Task",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
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
                  addTask();
                },
                child: Text("Add Task")),
          )
        ],
      ),
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

  void addTask() {

    if (formControll.currentState?.validate() == true) {
      Task task = Task(
          title: title, desc: desc, date: DateUtils.dateOnly(selectdate).microsecondsSinceEpoch );

      showLoading("loading...", context, isCanceld: false);
      addTasks(task).then((value) {
        hideDialog(context);
        showMesage(
          "Task added Done ",
          context,
          "ok",
          () {
            Navigator.pop(context);
                        Navigator.pop(context);

          },
        );
      }).catchError((onError) {
        hideDialog(context);
      });

    }
  }
}
