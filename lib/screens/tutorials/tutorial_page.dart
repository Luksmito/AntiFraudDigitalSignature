import 'package:crypto_id/components/screen_title.dart';
import 'package:crypto_id/screens/tutorials/add_signature_tutorial.dart';
import 'package:crypto_id/screens/tutorials/generate_keys_tutorial.dart';
import 'package:crypto_id/screens/tutorials/introduction.dart';
import 'package:crypto_id/screens/tutorials/sign_message_tutorial.dart';
import 'package:crypto_id/screens/tutorials/signatures_list_tutorial.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});


  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _selectedIndex = 0;

  static const List<Widget> widgetOptions = <Widget>[
    Introduction(),
    GenerateKeysTutorial(),
    SignMessageTutorial(),
    AddSignatureTutorial(),
    SignaturesListTutorial(),
  ];

  static const List<String> titles = [
    "Introdução",
    "Gerar chaves",
    "Assinar mensagens",
    "Adicionar assinaturas",
    "Assinaturas cadastradas",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Scaffold(
        appBar: AppBar(
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.primary),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            title: ScreenTitle(title: titles[_selectedIndex])),
        body: Center(child: widgetOptions[_selectedIndex]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            
            setState(() {
              _selectedIndex = (_selectedIndex + 1) % 5;
            });
          },
          tooltip: 'Próxima página',
          child: Icon(Icons.arrow_right_alt_rounded, color: Theme.of(context).colorScheme.onSecondary,),
        ),
      ),
    );
  }
}
