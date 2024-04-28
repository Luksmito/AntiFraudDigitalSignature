import 'package:crypto_id/components/standard_screen.dart';
import 'package:crypto_id/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/other_keys_controller.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:showcaseview/showcaseview.dart';

class AddSignaturePage extends StatefulWidget {
  const AddSignaturePage(
      {super.key,
      required this.isFirstTimeTutorial,
  });

  final bool isFirstTimeTutorial;


  @override
  State<AddSignaturePage> createState() => _AddSignature();
}

class _AddSignature extends State<AddSignaturePage> {
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _publicKeyController = TextEditingController();
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();

  void _addSignature() async {
    String name = _namesController.text;
    String publicKey = _publicKeyController.text;

    if (name.isEmpty || publicKey.isEmpty) {
      _showErrorDialog(
          "Erro!", "Digite o nome e a chave pública que deseja adicionar");
      return;
    }

    await DataBaseController().getTables();
    var otherKey = {'name': name, 'publicKey': publicKey};
    var otherKeysHelper = OtherKeysHelper();

    try {
      await otherKeysHelper.insertItem(otherKey);
      _showSuccessDialog("Sucesso!", "Chave adicionada com sucesso");
    } catch (e) {
      _showErrorDialog("Erro!", "Nome já cadastrado!");
    }
  }

  void _showErrorDialog(String title, String message) {
    exibirDialogoDeAviso(
      context,
      Text(title, style: Theme.of(context).textTheme.displayLarge),
      Text(message, style: Theme.of(context).textTheme.displayMedium),
      Text("OK", style: Theme.of(context).textTheme.displayMedium),
    );
  }

  void _showSuccessDialog(String title, String message) {
    exibirDialogoDeAviso(
      context,
      Text(title, style: Theme.of(context).textTheme.displayLarge),
      Text(message, style: Theme.of(context).textTheme.displayMedium),
      Text("OK", style: Theme.of(context).textTheme.displayMedium),
    );
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
              key: _one,
              title: "Identificador para a assinatura",
              description:
                  "Digite o nome da pessoa a que essa assinatura pertence",
              targetPadding: const EdgeInsets.all(8),
              child: LabeledTextField(
                controller: _namesController,
                textStyle: Theme.of(context).textTheme.displaySmall,
                labelText: "Nome",
                height: 48,
                labelStyle: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 10),
            Showcase(
              key: _two,
              title: "Chave pública",
              description:
                  "Coloque aqui a chave pública compartilhada com você",
              targetPadding: const EdgeInsets.all(8),
              child: LabeledTextField(
                controller: _publicKeyController,
                textStyle: Theme.of(context).textTheme.displaySmall,
                labelText: "Chave pública",
                labelStyle: Theme.of(context).textTheme.displayMedium,
                maxLines: 7,
                height: 80,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Spacer(),
                Showcase(
                  key: _three,
                  title: "Salve a identidade",
                  description: "Clique aqui para guardar a identidade",
                  targetPadding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: _addSignature,
                    child: Text("Adicionar",
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddSignature extends StatefulWidget {
  final bool isFirstTimeTutorial;
  final VoidCallback setShowTutorialCallback;
  const AddSignature(
      {super.key,
      required this.isFirstTimeTutorial,
      required this.setShowTutorialCallback,
      });

  @override
  State<AddSignature> createState() => _AddSignatureState();
}

class _AddSignatureState extends State<AddSignature> {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        onFinish: widget.setShowTutorialCallback,
        builder: Builder(builder: (context) {
          return AddSignaturePage(
              isFirstTimeTutorial: widget.isFirstTimeTutorial,
              );
        }));
  }
}
