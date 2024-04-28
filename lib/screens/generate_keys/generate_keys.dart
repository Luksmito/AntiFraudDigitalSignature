import 'package:crypto_id/components/button_with_showcase.dart';
import 'package:crypto_id/components/label_with_icon.dart';
import 'package:crypto_id/components/standard_screen.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/controllers/keys.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:crypto_id/controllers/db_controller.dart';
import 'package:showcaseview/showcaseview.dart';

class GenerateKeysPage extends StatefulWidget {
  const GenerateKeysPage({
    super.key,
    required this.isFirstTimeTutorial,
  });

  final bool isFirstTimeTutorial;
  @override
  State<GenerateKeysPage> createState() => _GenerateKeysPage();
}

class _GenerateKeysPage extends State<GenerateKeysPage> {
  final TextEditingController _privateKeyController = TextEditingController();
  final TextEditingController _publicKeyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();

  void saveKeys() async {
    if (_privateKeyController.text == "" ||
        _publicKeyController.text == "" ||
        _nameController.text == "") {
      _showErrorDialog(
          "Erro!", "Gere as chaves e escolha um nome para guarda-las");
      return;
    }
    if (_nameController.text == "-Chaves-") {
      _showErrorDialog("Erro!", "Nome inválido");
      return;
    }
    var item = {
      'name_my_key': _nameController.text,
      'privateKey': _privateKeyController.text,
      'publicKey': _publicKeyController.text
    };
    try {
      await MyKeysHelper().insertItem(item);
      _showSuccessDialog("Sucesso!", "Chaves guardadas com sucesso!");
    } catch (e) {
      _showErrorDialog("Erro na criação!", "Nome já existe no banco!");
    }
  }

  void _showErrorDialog(String title, String message) {
    exibirDialogoDeAviso(
      context,
      Text(title, style: Theme.of(context).textTheme.displayLarge),
      Text(message, style: Theme.of(context).textTheme.displayMedium),
      Text("ok", style: Theme.of(context).textTheme.displayMedium),
    );
  }

  void _showSuccessDialog(String title, String message) {
    exibirDialogoDeAviso(
      context,
      Text(title, style: Theme.of(context).textTheme.displayLarge),
      Text(message, style: Theme.of(context).textTheme.displayMedium),
      Text("ok", style: Theme.of(context).textTheme.displayMedium),
    );
  }

  void generateKeysAndShowOnTextField() {
    var key = generateKeys();
    setState(() {
      _privateKeyController.text = key.toHex();
      _publicKeyController.text = key.publicKey.toHex();
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isFirstTimeTutorial) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context).startShowCase([_one, _two, _three]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StandardScreen(
      keys: [_one, _two, _three],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Showcase(
              key: _two,
              title: "Identificador para as chaves",
              description: "Digite um nome para identificar a chave",
              child: LabeledTextField(
                height: 48,
                controller: _nameController,
                textStyle: Theme.of(context).textTheme.displaySmall,
                labelText: "Identificador das chaves",
                labelStyle: Theme.of(context).textTheme.displayMedium,
                maxLines: 1,
                contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              ),
            ),
            const SizedBox(
              height:10,
            ),
            LabelWIthIcon(
                label: "Chave privada",
                controllerToCopy: _privateKeyController),
            const SizedBox(
              height: 5,
            ),
            LabeledTextField(
                contentPadding: const EdgeInsets.all(6),
                controller: _privateKeyController,
                readOnly: true,
                textStyle: Theme.of(context).textTheme.displaySmall,
                labelText: "",
                height: 64,
                maxLines: 2,
                ),
            LabelWIthIcon(
                controllerToCopy: _publicKeyController, label: "Chave pública"),
            const SizedBox(
              height: 5,
            ),
            LabeledTextField(
              controller: _publicKeyController,
              readOnly: true,
              textStyle: Theme.of(context).textTheme.displaySmall,
              labelText: "",
              maxLines: 7,
              height: 80,
              contentPadding: const EdgeInsets.all(15),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWithShowcase(
                    showcaseKey: _one,
                    description: "Clique aqui para gerar suas chaves",
                    title: "Gerar chaves",
                    onPressed: generateKeysAndShowOnTextField,
                    buttonText: "Gerar chaves"),
                ButtonWithShowcase(
                    showcaseKey: _three,
                    description: "Clique aqui para guardar as chaves",
                    title: "Salve suas chaves",
                    onPressed: () async {
                      await DataBaseController().getTables();
                      saveKeys();
                    },
                    buttonText: "Salvar chaves")
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateKeys extends StatefulWidget {
  final Function(int) changePageCallback;
  final bool isFirstTimeTutorial;
  final VoidCallback setShowTutorialCallback;
  const GenerateKeys({
    super.key,
    required this.changePageCallback,
    required this.isFirstTimeTutorial,
    required this.setShowTutorialCallback,
  });

  @override
  State<GenerateKeys> createState() => _GenerateKeysState();
}

class _GenerateKeysState extends State<GenerateKeys> {
  void goForNextPageTutorial() {
    widget.setShowTutorialCallback();
    if (widget.isFirstTimeTutorial) widget.changePageCallback(3);
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        onFinish: goForNextPageTutorial,
        builder: Builder(builder: (context) {
          return GenerateKeysPage(
            isFirstTimeTutorial: widget.isFirstTimeTutorial,
          );
        }));
  }
}
