import 'package:crypto_id/components/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/other_keys_controller.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:crypto_id/controllers/db_controller.dart';

class AddSignature extends StatefulWidget {
  final List<GlobalKey> keys;
  const AddSignature({super.key, required this.keys});
  @override
  State<AddSignature> createState() => _AddSignature();
}

class _AddSignature extends State<AddSignature> {
  final _namesController = TextEditingController();
  final _publicKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
      child: Column(
        children: [
          const MyAppBar(title: "Adicionar assinatura",),
          LabeledTextField(
            controller: _namesController,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "Nome",
            labelStyle: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          LabeledTextField(
            controller: _publicKeyController,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "Chave pública",
            labelStyle: Theme.of(context).textTheme.displayMedium,
            height: 100,
            maxLines: 7,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                  key: widget.keys[0],
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () async {
                    var name = _namesController.text;
                    var publicKey = _publicKeyController.text;

                    if (name == "" || publicKey == "") {
                      exibirDialogoDeAviso(
                          context,
                          Text("Erro!",
                              style: Theme.of(context).textTheme.displayLarge),
                          Text(
                              "Digite o nome e a chave pública que deseja adicionar",
                              style: Theme.of(context).textTheme.displayMedium),
                          Text("OK",
                              style:
                                  Theme.of(context).textTheme.displayMedium));
                      return;
                    }

                    var otherKey = {
                      'name': _namesController.text,
                      'publicKey': _publicKeyController.text
                    };

                    var otherKeysHelper = OtherKeysHelper();
                    await DataBaseController().getTables();
                    try {
                      await otherKeysHelper.insertItem(otherKey);
                      exibirDialogoDeAviso(
                          context,
                          Text("Sucesso!",
                              style: Theme.of(context).textTheme.displayLarge),
                          Text("Chave adicionada com sucesso",
                              style: Theme.of(context).textTheme.displayMedium),
                          Text("OK",
                              style:
                                  Theme.of(context).textTheme.displayMedium));
                    } catch (e) {
                      exibirDialogoDeAviso(
                          context,
                          Text("Erro!",
                              style: Theme.of(context).textTheme.displayLarge),
                          Text("Nome ja cadastrado!",
                              style: Theme.of(context).textTheme.displayMedium),
                          Text("OK",
                              style:
                                  Theme.of(context).textTheme.displayMedium));
                    }
                  },
                  child: Text(
                    "Adicionar",
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
