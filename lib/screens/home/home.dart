import 'package:crypto_id/screens/home/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/screens/generate_keys/generate_keys.dart';
import 'package:crypto_id/screens/settings/settings.dart';
import 'package:crypto_id/screens/sign_message/sign_message.dart';
import 'package:crypto_id/screens/signatures_list.dart';
import 'package:crypto_id/screens/add_signature.dart';

class Home extends StatefulWidget {
  final List<GlobalKey> tutorialKeys = [GlobalKey(), GlobalKey(), GlobalKey()];
  final Function(bool) changeThemeCallback;
  final ThemeMode actualThemeMode;
  final bool showTutorial;
  Home(
      {super.key,
      required this.changeThemeCallback,
      required this.actualThemeMode,
      required this.showTutorial});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _selectedIndex = 2;

  void changePage(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  //Lista de páginas de do aplicativos
  @override
  void initState() {
    super.initState();
  }

  void selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      SignaturesList(
        changePageCallback: changePage,
      ),
      AddSignature(keys: [widget.tutorialKeys[2]]),
      GenerateKeys(
          changePageCallback: changePage, showTutorial: widget.showTutorial),
      SignMessage(
        showTutorial: widget.showTutorial,
      ),
      Settings(
        changeThemeCallback: widget.changeThemeCallback,
        actualThemeMode: widget.actualThemeMode,
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomBar(
        selectIndexCallback: selectIndex,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
