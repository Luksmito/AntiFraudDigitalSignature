import 'package:flutter/material.dart';

class RoundedQuestionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RoundedQuestionButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: Theme.of(context).colorScheme.primary, // Cor do botão
      ),
      child: Icon(
        Icons.question_mark, // Ícone de ponto de interrogação
        size: 24, // Tamanho do ícone
        color: Theme.of(context).colorScheme.onSecondary, // Cor do ícone
      ),
    );
  }
}