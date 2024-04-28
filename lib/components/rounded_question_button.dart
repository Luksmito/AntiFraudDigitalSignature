import 'package:flutter/material.dart';

class RoundedQuestionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Icon icon;
  const RoundedQuestionButton({Key? key, required this.onPressed, required this.icon, required this.backgroundColor}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: backgroundColor, // Cor do botão
      ),
      icon: icon
    );
  }
}