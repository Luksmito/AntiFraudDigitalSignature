import 'package:crypto_id/data/styles.dart';
import 'package:crypto_id/screens/TutorialScreen.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/db_controller.dart';
import 'screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setup() async {
  DataBaseController().initDb();

  await DataBaseController().getTables();
}

Future<void> main() async {
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
  late bool isFirstTime;
  late Widget screen;

  void changeTheme(bool value) {
    setState(() {
      if (value ) {
        actualTheme = ThemeMode.dark;
      } else {
        actualTheme = ThemeMode.light;
      }
      
    });
  }

  void onExitTutorial() {
    setState(() {
      screen = Home(changeThemeCallback: changeTheme, actualThemeMode: actualTheme, showTutorialFirst: isFirstTime,);
    });
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('first_time') ?? true;
    //prefs.setBool('first_time', true);
    if (isFirstTime) {
      screen = TutorialScreen(onExitTutorial: onExitTutorial);
      prefs.setBool('first_time', false);
    } else {
      screen = Home(changeThemeCallback: changeTheme, actualThemeMode: actualTheme, showTutorialFirst: isFirstTime,);
    }
    setState((){});
  }

  @override
  void initState() {
    super.initState();
    screen = const Placeholder();
    _checkFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeLight(context),  
      darkTheme: themeDark(context),
      themeMode: actualTheme,
      home: screen
    );
  }
}