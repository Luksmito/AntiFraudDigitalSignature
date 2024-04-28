import 'package:crypto_id/components/rounded_question_button.dart';
import 'package:crypto_id/components/screen_title.dart';
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
  List<String> titles = [
    "Assinaturas",
    "Adicionar assinatura",
    "Gerar chaves",
    "Assinar mensagem"
  ];

  void changePage(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  void showSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Settings(
                changeThemeCallback: widget.changeThemeCallback,
                actualThemeMode: widget.actualThemeMode,
              )),
    );
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
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: ScreenTitle(
            title: titles[_selectedIndex],
          ),
          actions: [
            RoundedQuestionButton(
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              onPressed: showSettings,
              icon: Icon(
                Icons.settings, // Ícone de ponto de interrogação
                size: 24, // Tamanho do ícone
                color: Theme.of(context).colorScheme.primary, // Cor do ícone
              ),
            )
          ]),
      body: Container(
        child: widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomBar(
        selectIndexCallback: selectIndex,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
