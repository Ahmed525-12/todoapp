import 'package:flutter/material.dart';
import 'package:todoapp/screens/home/bottomsheet.dart';
import 'package:todoapp/screens/settings/settings.dart';
import 'package:todoapp/screens/tasks/taskspage.dart';


class HomePage extends StatefulWidget {
  static const String routename = "homepage";
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Route Task Manager "),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
            currentIndex: currentindex,
            onTap: (value) {
              currentindex = value;
              setState(() {});
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          showBottomSheet();
        },
        child: const Icon(Icons.add),
        shape: StadiumBorder(
            side: BorderSide(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 4,
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabss[currentindex],
    );
  }

  List<Widget> tabss = [
     TasksTab(),
    Settingstab(),
  ];

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return BottomSheetTab();
        });
  }
}
