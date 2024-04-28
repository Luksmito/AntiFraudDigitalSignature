import 'package:crypto_id/components/standard_screen.dart';
import 'package:crypto_id/screens/sign_message/dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';
import 'package:crypto_id/screens/sign_message/message_pair.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'keys_controller.dart';
import 'key_pair_fields.dart';
import 'key_change_notifier.dart';

class SignMessagePage extends StatefulWidget {
  const SignMessagePage(
      {super.key,
      required this.isFirstTimeTutorial,
});


  final bool isFirstTimeTutorial;

  @override
  State<SignMessagePage> createState() => _SignMessagePage();
}

class _SignMessagePage extends State<SignMessagePage> {
  String privateKeyText = "";
  String publicKeyText = "";

  KeysController keysController = KeysController();
  final KeyChangeNotifier keyChangeNotifier = KeyChangeNotifier();
  MyKey keyPair = const MyKey();
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();
  final GlobalKey _five = GlobalKey();

  bool showTutorial = true;

  List<MyKey> keysRegistered = [];
  List<DropdownMenuItem<String>> dropDownTexts = [];

  @override
  void initState() {
    super.initState();
    _initData();
    if (widget.isFirstTimeTutorial) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context)
              .startShowCase([_one, _two, _three, _four, _five]));
    }
  }

  Future<void> _initData() async {
    keysRegistered = await keysController.getAllKeysRegistered();
  }

  @override
  Widget build(BuildContext context) {
    return StandardScreen(
      keys: [_one, _two, _three, _four, _five],
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Showcase(
                key: _one,
                description: "Selecione a chave que deseja usar aqui",
                title: "Seletor de chave",
                child: FutureBuilder(
                    future: _initData(),
                    builder: ((context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                        default:
                          return DropDownMyKeys(
                            keysRegistered: keysRegistered,
                            keyChangeNotifier: keyChangeNotifier,
                          );
                      }
                    }))),
            ListenableBuilder(
                listenable: keyChangeNotifier,
                builder: (context, child) {
                  keyPair = keyChangeNotifier.keyPair;
                  privateKeyText = keyPair.privateKey;
                  publicKeyText = keyPair.publicKey;
                  return Column(
                    children: [
                      Showcase(
                          targetPadding: const EdgeInsets.all(5),
                          key: _two,
                          title: "Suas chaves",
                          description:
                              "Ao selecionar seu par de chaves ele aparece aqui, a chave pública você pode mandar para outros, não revele sua chave privada.",
                          child: KeyPairFields(
                              privateKeyText: privateKeyText,
                              publicKeyText: publicKeyText)),
                      const SizedBox(
                        height: 15,
                      ),
                      MessagePair(
                          keyPair: keyPair,
                          tutorialKeys: [_three, _four, _five])
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class SignMessage extends StatefulWidget {
  const SignMessage(
      {super.key,
      required this.isFirstTimeTutorial,
      required this.setShowTutorialCallback,
      });

  final VoidCallback setShowTutorialCallback;
  final bool isFirstTimeTutorial;
  @override
  State<SignMessage> createState() => _SignMessageState();
}

class _SignMessageState extends State<SignMessage> {
  void disableTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', false);
    widget.setShowTutorialCallback();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        onFinish: disableTutorial,
        builder: Builder(builder: (context) {
          return SignMessagePage(
              isFirstTimeTutorial: widget.isFirstTimeTutorial,
              );
        }));
  }
}
