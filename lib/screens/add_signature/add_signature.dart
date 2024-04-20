import 'package:crypto_id/components/my_appbar.dart';
import 'package:crypto_id/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/other_keys_controller.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/data/utils.dart';

class AddSignature extends StatefulWidget {
  const AddSignature({super.key});
  @override
  State<AddSignature> createState() => _AddSignature();
}

class _AddSignature extends State<AddSignature> {
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _publicKeyController = TextEditingController();

  void _addSignature() async {
    String name = _namesController.text;
    String publicKey = _publicKeyController.text;

    if (name.isEmpty || publicKey.isEmpty) {
      _showErrorDialog("Erro!", "Digite o nome e a chave pública que deseja adicionar");
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
      child: Column(
        children: [
          const MyAppBar(title: "Adicionar assinatura"),
          LabeledTextField(
            controller: _namesController,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "Nome",
            labelStyle: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 10),
          LabeledTextField(
            controller: _publicKeyController,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "Chave pública",
            labelStyle: Theme.of(context).textTheme.displayMedium,
            height: 100,
            maxLines: 7,
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: _addSignature,
                child: Text("Adicionar", style: Theme.of(context).textTheme.labelLarge),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
