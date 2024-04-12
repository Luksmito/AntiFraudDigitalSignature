import 'package:elliptic/elliptic.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:crypto_id/controllers/keys.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';

class MessagePair extends StatefulWidget {
  final MyKey keyPair;

  const MessagePair({super.key, this.keyPair = const MyKey()});

  @override
  State<StatefulWidget> createState() {
    return _MessagePairState();
  }
}

class _MessagePairState extends State<MessagePair> {
  TextEditingController messageTextController = TextEditingController();
  TextEditingController signedMessageController = TextEditingController();
  Color colorMessage = Colors.blueGrey;

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
    var privateKeyObject =
        PrivateKey.fromHex(getP256(), widget.keyPair.privateKey);
    Signature assinatura;
    if (messageTextController.text == "") {
      assinatura = generateStandardSignature(privateKeyObject);
    } else {
      assinatura = signMessage(messageTextController.text, privateKeyObject);
    }
    signedMessageController.text = assinatura.toCompactHex();
  }

  bool keyPairWasAssigned() {
    return widget.keyPair.name != "";
  }

  @override
  Widget build(BuildContext context) {
    messageTextController.text = padrao;
    print(widget.keyPair.name);
    return Column(
      children: [
        LabeledTextField(
          controller: messageTextController,
          textStyle: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: colorMessage),
          labelText: "Mensagem",
          labelStyle: Theme.of(context).textTheme.displayMedium,
          maxLines: 7,
          height: 77,
          onTap: changeMessageColorAndEraseStandardMessage,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
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
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Mensagem assinada",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            IconButton(
                constraints:
                    const BoxConstraints.tightFor(width: 15, height: 15),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  copyText(signedMessageController.text, context);
                },
                icon: const Icon(Icons.copy, size: 20))
          ],
        ),
        LabeledTextField(
          controller: signedMessageController,
          readOnly: true,
          textStyle: Theme.of(context).textTheme.displayMedium,
          labelText: "",
          maxLines: 7,
          height: 77,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ],
    );
  }
}
