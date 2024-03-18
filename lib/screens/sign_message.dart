import 'package:elliptic/elliptic.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/components/labeled_text_field.dart';
import 'package:todo_list/components/screen_title.dart';
import 'package:todo_list/controllers/keys.dart';
import 'package:todo_list/data/styles.dart';
import 'package:todo_list/controllers/my_keys_controller.dart';
import 'package:todo_list/data/utils.dart';
import 'package:ecdsa/ecdsa.dart';

Future<List<Map<String, dynamic>>> getKeysRegistered(
    MyKeysHelper myKeysHelper) async {
  return await myKeysHelper.getAllItems();
}

class SignMessage extends StatefulWidget {
  const SignMessage({super.key});

  @override
  State<SignMessage> createState() => _SignMessage();
}

class _SignMessage extends State<SignMessage> {
  bool isPressedEye1 = true;

  var privateKeyTextController = TextEditingController();
  var publicKeyTextController = TextEditingController();
  var messageTextController = TextEditingController();
  var signedMessageController = TextEditingController();
  var dropDownController = TextEditingController();

  var keyPair;
  var dbHelper = MyKeysHelper();
  List<MyKey> keysRegistered = [];
  List<DropdownMenuItem<String>> dropDownTexts = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTitle(title: "Assinar mensagem"),
          FutureBuilder(
            future: _initData(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                default:
                  return Row(
                    children: [
                      Expanded(
                        child: DropdownMenu<MyKey>(
                          initialSelection: null,
                          label: Text(
                            "Selecione uma chave",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          textStyle: Theme.of(context).textTheme.displayMedium,
                          controller: dropDownController,
                          width: 301,
                          enableFilter: false,
                          enableSearch: false,
                          requestFocusOnTap: true,
                          onSelected: (MyKey? key) {
                            setState(() {
                              keyPair = key;
                              privateKeyTextController.text =
                                  keyPair.privateKey;
                              publicKeyTextController.text = keyPair.publicKey;
                            });
                          },
                          dropdownMenuEntries: keysRegistered
                              .map<DropdownMenuEntry<MyKey>>((MyKey key) {
                            return DropdownMenuEntry<MyKey>(
                              value: key,
                              label: key.name,
                              style: MenuItemButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
              }
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chave privada",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              IconButton(
                constraints: const BoxConstraints.tightFor(width: 30, height: 40),
                color: Theme.of(context).colorScheme.primary,
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    isPressedEye1 = !isPressedEye1;
                  });
                },
                icon: isPressedEye1
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              IconButton(
                  constraints: const BoxConstraints.tightFor(width: 30, height: 40),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: 20,
                  onPressed: () {
                    copyText(privateKeyTextController.text, context);
                  },
                  icon: const Icon(Icons.copy)),
            ],
          ),
          LabeledTextField(
            obscureText: isPressedEye1,
            controller: privateKeyTextController,
            readOnly: true,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "",
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chave pública",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              IconButton(
                  constraints: const BoxConstraints.tightFor(width: 30, height: 40),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    copyText(publicKeyTextController.text, context);
                  },
                  icon: const Icon(Icons.copy, size: 20)),
            ],
          ),
          LabeledTextField(
            controller: publicKeyTextController,
            readOnly: true,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "",
            maxLines: 7,
            height: 77,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          const SizedBox(
            height: 15,
          ),
          LabeledTextField(
            controller: messageTextController,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "Mensagem",
            labelStyle: Theme.of(context).textTheme.displayMedium,
            maxLines: 7,
            height: 77,
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
                      if (keyPair == null) {
                        exibirDialogoDeAviso(
                            context,
                            const Text("Erro!"),
                            Text("Selecione um par de chaves!"),
                            const Text("Ok"));
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
                  constraints: const BoxConstraints.tightFor(width: 30, height: 40),
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
      ),
    );
  }

  Future<void> generateSignedMessage() async {
    var privateKeyObject = PrivateKey.fromHex(getP256(), keyPair.privateKey);
    Signature assinatura;
    if (messageTextController.text == "") {
      assinatura = generateStandardSignature(privateKeyObject);
    } else {
      assinatura = signMessage(messageTextController.text, privateKeyObject);
    }
    signedMessageController.text = assinatura.toCompactHex();
  }

  Future<void> _initData() async {
    var aux = await getKeysRegistered(dbHelper);
    keysRegistered.clear();
    aux.forEach((element) {
      keysRegistered.add(MyKey.fromMap(element));
    });
  }
}
