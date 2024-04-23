import 'package:crypto_id/screens/home/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/screens/generate_keys/generate_keys.dart';
import 'package:crypto_id/screens/settings/settings.dart';
import 'package:crypto_id/screens/sign_message/sign_message.dart';
import 'package:crypto_id/screens/signatures_list/signatures_list.dart';
import 'package:crypto_id/screens/add_signature/add_signature.dart';

class Home extends StatefulWidget {
  final Function(bool) changeThemeCallback;
  final ThemeMode actualThemeMode;
  final bool showTutorialFirst;
  Home(
      {super.key,
      required this.changeThemeCallback,
      required this.actualThemeMode,
      required this.showTutorialFirst});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _selectedIndex = 2;
  int n_pages = 5;
  List<bool> showTutorialFirst = List.generate(4, (index) => false);

  void changePage(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  //Lista de páginas de do aplicativos
  @override
  void initState() {
    super.initState();
    showTutorialFirst = List.generate(4, (index) => widget.showTutorialFirst);
  }

  void selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void setShowTutorial() {
    showTutorialFirst[_selectedIndex] = false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      SignaturesList(
        isFirstTimeTutorial: showTutorialFirst[0],
        setShowTutorialCallback: setShowTutorial,
        changePageCallback: changePage,
      ),
      AddSignature(
        isFirstTimeTutorial: showTutorialFirst[1],
        setShowTutorialCallback: setShowTutorial,
      ),
      GenerateKeys(
        isFirstTimeTutorial: showTutorialFirst[2],
        setShowTutorialCallback: setShowTutorial,
        changePageCallback: changePage,
      ),
      SignMessage(
        isFirstTimeTutorial: showTutorialFirst[3],
        setShowTutorialCallback: setShowTutorial,
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
