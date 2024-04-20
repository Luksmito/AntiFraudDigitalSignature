import 'package:crypto_id/components/button_with_showcase.dart';
import 'package:crypto_id/components/label_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/components/screen_title.dart';
import 'package:crypto_id/controllers/keys.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:crypto_id/controllers/db_controller.dart';
import 'package:showcaseview/showcaseview.dart';

class GenerateKeysPage extends StatefulWidget {
  
  const GenerateKeysPage({super.key});

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
      _showErrorDialog("Erro!", "Gere as chaves e escolha um nome para guarda-las");
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

  void generateKeysAndShowOnTextField () {
    var key = generateKeys();
    setState(() {
    _privateKeyController.text = key.toHex();
    _publicKeyController.text = key.publicKey.toHex();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_one, _two,_three]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
          child: Column(
            children: [
              const ScreenTitle(title: "Gerar Chaves"),
              LabelWIthIcon(label: "Chave pública", controllerToCopy: _privateKeyController),
              LabeledTextField(
                controller: _privateKeyController,
                readOnly: true,
                textStyle: Theme.of(context).textTheme.displayMedium,
                labelText: "",
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWIthIcon(controllerToCopy: _privateKeyController, label: "Chave privada"),
              LabeledTextField(
                controller: _publicKeyController,
                readOnly: true,
                textStyle: Theme.of(context).textTheme.displayMedium,
                labelText: "",
                maxLines: 7,
                height: 77,
                contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              ),
              const SizedBox(
                height: 15,
              ),
              Showcase(
                key: _two,
                title: "Identificador para as chaves",
                description: "Digite um nome para identificar a chave",
                child: LabeledTextField(
                  controller: _nameController,
                  textStyle: Theme.of(context).textTheme.displayMedium,
                  labelText: "Identificador das chaves",
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                  maxLines: 1,
                  contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                ),
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
                    buttonText: "Gerar chaves"
                  ),  
                  ButtonWithShowcase(
                    showcaseKey: _three, 
                    description: "Clique aqui para guardar as chaves", 
                    title: "Salve suas chaves", 
                    onPressed: () async {
                      await DataBaseController().getTables();
                      saveKeys();
                    }, 
                    buttonText: "Guardar chaves"
                  )   
                ],
              ),
            ],
          ),
        );
  }
}

class GenerateKeys extends StatefulWidget {
  final Function(int) changePageCallback;
  final bool showTutorial;
  const GenerateKeys({super.key, required this.changePageCallback, required this.showTutorial});

  @override
  State<GenerateKeys> createState() => _GenerateKeysState();
}

class _GenerateKeysState extends State<GenerateKeys> {
  
  void goForNextPageTutorial() {
    widget.changePageCallback(3);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      enableShowcase: widget.showTutorial,
      onFinish: goForNextPageTutorial,
      builder: Builder(builder: (context) {
      
        return const GenerateKeysPage();
      }
      ));
  }
}