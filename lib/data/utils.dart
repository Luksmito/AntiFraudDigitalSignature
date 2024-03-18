import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyText(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Texto copiado para a área de transferência'),
      ),
    );
}

Future<void> exibirDialogoDeAviso(
    BuildContext context, Text title, Text content, Text buttonText) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o AlertDialog
            },
            child: buttonText,
          ),
        ],
      );
    },
  );
}