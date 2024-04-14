import 'package:crypto_id/main.dart';
import 'package:crypto_id/screens/tutorials/TutorialFlow.dart';
import 'package:crypto_id/screens/tutorials/TutorialStep.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/components/screen_title.dart';
import 'package:crypto_id/controllers/keys.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:crypto_id/controllers/db_controller.dart';
import 'package:flutter/widgets.dart';

class GenerateKeys extends StatefulWidget {
  final Function(int) changePageCallback;
  const GenerateKeys({super.key, required this.changePageCallback});

  @override
  State<GenerateKeys> createState() => _GenerateKeys();
}

class _GenerateKeys extends State<GenerateKeys> {
  final TextEditingController _privateKeyController = TextEditingController();
  final TextEditingController _publicKeyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TutorialFlow tutorialFlow = TutorialFlow(nSteps: 4);
  bool showTutorial = true;

  void saveKeys() async {
    if (_privateKeyController.text == "" ||
        _publicKeyController.text == "" ||
        _nameController.text == "") {
      exibirDialogoDeAviso(
          context,
          Text("Erro!", style: Theme.of(context).textTheme.displayLarge),
          Text("Gere as chaves e escolha um nome para guarda-las",
              style: Theme.of(context).textTheme.displayMedium),
          Text("ok", style: Theme.of(context).textTheme.displayMedium));
      return;
    }
    if (_nameController.text == "-Chaves-") {
      exibirDialogoDeAviso(
          context,
          Text("Erro!", style: Theme.of(context).textTheme.displayLarge),
          Text("Nome inválido",
              style: Theme.of(context).textTheme.displayMedium),
          Text("ok", style: Theme.of(context).textTheme.displayMedium));
      return;
    }
    var item = {
      'name_my_key': _nameController.text,
      'privateKey': _privateKeyController.text,
      'publicKey': _publicKeyController.text
    };
    var dbHelper = MyKeysHelper();
    try {
      await dbHelper.insertItem(item);
      exibirDialogoDeAviso(
          context,
          Text("Sucesso!", style: Theme.of(context).textTheme.displayLarge),
          Text("Chaves guardadas com sucesso!",
              style: Theme.of(context).textTheme.displayMedium),
          Text("ok", style: Theme.of(context).textTheme.displayMedium));
    } catch (e) {
      print(e);
      exibirDialogoDeAviso(
          context,
          Text("Erro na criação!",
              style: Theme.of(context).textTheme.displayLarge),
          Text("Nome já existe no banco!",
              style: Theme.of(context).textTheme.displayMedium),
          Text("ok", style: Theme.of(context).textTheme.displayMedium));
    }
  }



  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
      child: Column(
        children: [
          const ScreenTitle(title: "Gerar Chaves"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chave privada",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              IconButton(
                  constraints:
                      const BoxConstraints.tightFor(width: 15, height: 15),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    copyText(_privateKeyController.text, context);
                  },
                  icon: const Icon(Icons.copy, size: 20))
            ],
          ),
          LabeledTextField(
            controller: _privateKeyController,
            readOnly: true,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "",
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Chave publica",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              IconButton(
                  constraints:
                      const BoxConstraints.tightFor(width: 15, height: 15),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    copyText(_publicKeyController.text, context);
                  },
                  icon: const Icon(Icons.copy, size: 20))
            ],
          ),
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
          AbsorbPointer(
            absorbing: !tutorialFlow.tutorialSteps[1] && showTutorial,
            child: TutorialStep(
              boxHeight: 100,
              boxWidth: MediaQuery.of(context).size.width,
              padding: 8,
              message: "Digite o nome que quer dar as chaves aqui",
              highlight: tutorialFlow.tutorialSteps[1],
              child: LabeledTextField(
                onEditingComplete: () {
                  if (showTutorial && tutorialFlow.actualStep == 1) {
                    setState(() {
                      
                      tutorialFlow.nextStep();
                    });
                  }
                },
                controller: _nameController,
                textStyle: Theme.of(context).textTheme.displayMedium,
                labelText: "Identificador das chaves",
                labelStyle: Theme.of(context).textTheme.displayMedium,
                maxLines: 1,
                contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                AbsorbPointer(
                  absorbing: !tutorialFlow.tutorialSteps[0] && showTutorial,
                  child: TutorialStep(
                    boxHeight: 60,
                    boxWidth: 180,
                    message: "Clique aqui para gerar suas chaves",
                    highlight: tutorialFlow.tutorialSteps[0],
                    child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {
                          var key = generateKeys();
                          if (tutorialFlow.actualStep == 0) {
                            tutorialFlow.nextStep();
                          }
                          setState(() {
                            _privateKeyController.text = key.toHex();
                            _publicKeyController.text = key.publicKey.toHex();
                          });
                          
                        },
                        child: Text(
                          "Gerar chaves",
                          style: Theme.of(context).textTheme.labelLarge,
                        )),
                  ),
                ),
              AbsorbPointer(
                absorbing: !tutorialFlow.tutorialSteps[2] && showTutorial,
                child: TutorialStep(
                  boxHeight: 60,
                  boxWidth: 200,
                  message: "Clique aqui para guardar",
                  highlight: tutorialFlow.tutorialSteps[2],
                  child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () async {
                    if (showTutorial) {
                      showTutorial = false;

                      setState(() {
                        tutorialFlow.nextStep();
                      });
                      widget.changePageCallback(3);
                    }
                    await DataBaseController().getTables();
                    saveKeys();
                    
                    //await deleteDatabaseFile();
                    //print(await DataBaseController().getTables());
                  },
                  child: Text(
                    "Guardar chaves",
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
