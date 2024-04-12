import 'package:crypto_id/data/styles.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/db_controller.dart';
import './screens/home.dart';

void setup() async {
  DataBaseController().initDb();

  await DataBaseController().getTables();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeLight(context),  
      darkTheme: themeDark(context),
      themeMode: actualTheme,
      home: Home(changeThemeCallback: changeTheme, actualThemeMode: actualTheme,),
    );
  }
}