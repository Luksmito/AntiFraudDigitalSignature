
import 'package:crypto_id/components/rounded_question_button.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class StandardScreen extends StatelessWidget {

  const StandardScreen(
    {
      super.key,
      required this.child,
      required this.keys
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
        onPressed: () {
          startTutorial(context);
        },
      ),
      body: child,
    );
  }
  
}