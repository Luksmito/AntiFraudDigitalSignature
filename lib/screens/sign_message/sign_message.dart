import 'package:flutter/material.dart';
import 'package:crypto_id/components/screen_title.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';
import 'package:crypto_id/screens/sign_message/message_pair.dart';
import 'keys_controller.dart';
import 'key_pair_fields.dart';
import 'key_change_notifier.dart';


class SignMessage extends StatefulWidget {
  const SignMessage({super.key});

  @override
  State<SignMessage> createState() => _SignMessage();
}

class _SignMessage extends State<SignMessage> {
  var dropDownController = TextEditingController();

  String privateKeyText = "";
  String publicKeyText = "";

  KeysController keysController = KeysController();
  final KeyChangeNotifier keyChangeNotifier = KeyChangeNotifier();

  MyKey keyPair = const MyKey();


  List<MyKey> keysRegistered = [];
  List<DropdownMenuItem<String>> dropDownTexts = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    keysRegistered = await keysController.getAllKeysRegistered();
  }

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
                            keyChangeNotifier.setkeys(key!);
                            setState(() {
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
          ListenableBuilder(listenable: keyChangeNotifier , 
          builder: (context, child)  {
            keyPair = keyChangeNotifier.keyPair;
            privateKeyText = keyPair.privateKey;
            publicKeyText = keyPair.publicKey;
            return Column(children: [
              KeyPairFields(privateKeyText: privateKeyText, publicKeyText: publicKeyText),
              const SizedBox(
                height: 15,
              ),
            MessagePair(keyPair: keyPair)
            ],);
          }),
          
        ],
      ),
    );
  }

  
}





