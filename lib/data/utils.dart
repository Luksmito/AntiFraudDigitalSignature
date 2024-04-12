import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showMenuToPasteText(BuildContext context, TextEditingController controller,
    {int offset = 0}) {
  RenderBox box = context.findRenderObject() as RenderBox;
  Offset position = box.localToGlobal(Offset.zero);
  print("px: ${position.dx}");
  // Exibe um menu de contexto perto do campo de texto
  showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx + 150, position.dy + 35 + offset, position.dx, 0),
      items: [
        PopupMenuItem(
          child: const Text('Colar'),
          onTap: () async {
            // Cola o texto da área de transferência no campo de texto
            final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
            if (clipboardData != null && clipboardData.text != null) {
              controller.text = clipboardData.text!;
            }
          },
        )
      ]);
}

void copyText(String text, BuildContext context) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Texto copiado para a área de transferência'),
    ),
  );
}

Future<bool?> exibirDialogoDeConfirmacao(
    BuildContext context, Text title, Text content) async {
  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                // Fechar o diálogo sem realizar nenhuma ação
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Fechar o diálogo e confirmar a ação
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      });
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
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.tertiary)),
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
