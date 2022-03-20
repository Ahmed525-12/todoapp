import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/screens/home/hompage.dart';

void main() async{

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do ',
      theme:MyThemeData.lightTheme,
      routes: {
          HomePage.routename:(context) => HomePage(),
      },
      initialRoute:HomePage.routename ,
    );
  }
}
