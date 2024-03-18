import 'package:todo_list/data/styles.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/controllers/db_controller.dart';
import 'package:todo_list/data/styles.dart';
import './screens/home.dart';
import 'package:todo_list/controllers/db_controller.dart';

void setup() {
 DataBaseController().initDb();
}

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var actualTheme = ThemeMode.light;

  void changeTheme(bool value) {
    setState(() {
      if (value ) {
        actualTheme = ThemeMode.dark;
      } else {
        actualTheme = ThemeMode.light;
      }
      
    });
    
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeLight(context),  
      darkTheme: themeDark(context),
      themeMode: actualTheme,
      home: Home(changeThemeCallback: changeTheme, actualThemeMode: actualTheme,),
    );
  }
}