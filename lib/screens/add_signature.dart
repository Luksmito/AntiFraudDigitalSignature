import 'package:flutter/material.dart';
import 'package:todo_list/components/screen_title.dart';
import 'package:todo_list/controllers/other_keys_controller.dart';
import 'package:todo_list/data/styles.dart';
import 'package:todo_list/components/labeled_text_field.dart';
import 'package:todo_list/data/utils.dart';

class AddSignature extends StatefulWidget {
  const AddSignature({super.key});

  @override
  State<AddSignature> createState() => _AddSignature();
}

class _AddSignature extends State<AddSignature> {

  final _namesController = TextEditingController();
  final _publicKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 20, 36,0),
      child: Column(
        children: [
          const ScreenTitle(title: "Adicionar assinatura",),
          LabeledTextField(
            controller: _namesController,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "Nome",
          ),
          const SizedBox(height: 10,),
          LabeledTextField(
            controller: _publicKeyController,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "Chave pública",
            height: 100,
            maxLines: 7,
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () async {
                  var name = _namesController.text;
                  var publicKey = _publicKeyController.text;

                  if (name == "" || publicKey == "") {
                    exibirDialogoDeAviso(
                        context, 
                        const Text("Erro!"), 
                        const Text("Digite o nome e a chave pública que deseja adicionar"), 
                        const Text("OK")
                    );
                      return;
                  }

                  var otherKey = {
                    'name': _namesController.text,
                    'publicKey': _publicKeyController.text
                  };

                  var otherKeysHelper = OtherKeysHelper();
                  var result = await otherKeysHelper.insertItem(otherKey);

                  if (result != 0) {
                    exibirDialogoDeAviso(
                        context, 
                        const Text("Sucesso!"), 
                        const Text("Chave adicionada com sucesso"), 
                        const Text("OK")
                    );
                  }
                }, 
                child: Text(
                  "Adicionar", 
                  style: Theme.of(context).textTheme.labelLarge,
                ) 
              ),
            ],
          )
        ],
      ),
        
    );
  }

}


