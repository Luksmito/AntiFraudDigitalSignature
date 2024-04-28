import 'package:elliptic/elliptic.dart';

import 'package:flutter/material.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:crypto_id/controllers/keys.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';

import 'package:showcaseview/showcaseview.dart';

class MessagePair extends StatefulWidget {
  final MyKey keyPair;
  final List<GlobalKey> tutorialKeys;

  const MessagePair(
      {super.key, this.keyPair = const MyKey(), required this.tutorialKeys});

  @override
  State<StatefulWidget> createState() {
    return _MessagePairState();
  }
}

class _MessagePairState extends State<MessagePair> {
  TextEditingController messageTextController = TextEditingController();
  TextEditingController signedMessageController = TextEditingController();
  Color colorMessage = Colors.blueGrey;

  static const paddingShowCase = EdgeInsets.all(5);

  String padrao = "Mensagem Padrao";
  bool firstTimeMessageChanged = true;
  void changeMessageColorAndEraseStandardMessage() {
    setState(() {
      if (firstTimeMessageChanged) {
        colorMessage = Theme.of(context).colorScheme.onPrimary;
        messageTextController.text = "";
        padrao = "";
        firstTimeMessageChanged = false;
      }
    });
  }

  Future<void> generateSignedMessage() async {
    final privateKeyObject =
        PrivateKey.fromHex(getP256(), widget.keyPair.privateKey);
    final assinatura = messageTextController.text.isEmpty
        ? generateStandardSignature(privateKeyObject)
        : signMessage(messageTextController.text, privateKeyObject);

    signedMessageController.text = assinatura.toCompactHex();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          insetPadding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Mensagem Assinada com sucesso!", style: Theme.of(context).textTheme.displayMedium,),
                const SizedBox(height: 20,),
                Center(
                  child: Text(
                    "Copie o código abaixo para verificar sua assinatura.",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(height: 20,),
                LabeledTextField(
                  controller: signedMessageController,
                  readOnly: true,
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  labelText: "",
                  maxLines: 7,
                  height: 77,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                onPressed: () {
                  setState(() {
                    copyText(signedMessageController.text, context);
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(251, 44),
                ),
                child: Text(
                  "Copiar o código",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool keyPairWasAssigned() {
    return widget.keyPair.name != "";
  }

  @override
  Widget build(BuildContext context) {
    messageTextController.text = padrao;
    return Column(
      children: [
        Showcase(
          targetPadding: paddingShowCase,
          key: widget.tutorialKeys[0],
          title: "Mensagem",
          description:
              "Você pode escrever a mensagem que deseja assinar aqui ou pode deixar a mensagem padrão.",
          child: LabeledTextField(
            controller: messageTextController,
            textStyle: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: colorMessage),
            labelText: "Mensagem",
            labelStyle: Theme.of(context).textTheme.displayMedium,
            maxLines: 2,
            height: 48,
            onTap: changeMessageColorAndEraseStandardMessage,
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Showcase(
            targetPadding: paddingShowCase,
            key: widget.tutorialKeys[1],
            title: "Assine a mensagem",
            description: "Aperte aqui para assinar a mensagem.",
            child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 44))),
                onPressed: () {
                  setState(() {
                    if (!keyPairWasAssigned()) {
                      exibirDialogoDeAviso(
                          context,
                          Text("Erro!",
                              style: Theme.of(context).textTheme.displayLarge),
                          Text("Selecione um par de chaves!",
                              style: Theme.of(context).textTheme.displayMedium),
                          Text("Ok",
                              style:
                                  Theme.of(context).textTheme.displayMedium));
                    } else {
                      generateSignedMessage();
                    }
                  });
                },
                child: Text(
                  "Assinar Mensagem",
                  style: Theme.of(context).textTheme.labelLarge,
                ))),
      ],
    );
  }
}
