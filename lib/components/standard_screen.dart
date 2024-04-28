
import 'package:crypto_id/components/rounded_question_button.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class StandardScreen extends StatelessWidget {

  const StandardScreen(
    {
      super.key,
      required this.child,
      required this.keys,

    }
  );

  final Widget child;
  final List<GlobalKey> keys;


  void startTutorial(BuildContext context) {
    ShowCaseWidget.of(context).startShowCase(keys);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RoundedQuestionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(
        Icons.question_mark, // Ícone de ponto de interrogação
        size: 24, // Tamanho do ícone
        color: Theme.of(context).colorScheme.onSecondary, // Cor do ícone
      ),
        onPressed: () {
          startTutorial(context);
        },
      ),
      body: child,
    );
  }
  
}