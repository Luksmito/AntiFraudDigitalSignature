import 'package:flutter/material.dart';

import 'package:todo_list/components/labeled_text_field.dart';
import 'package:todo_list/components/screen_title.dart';
import 'package:todo_list/data/styles.dart';
import 'package:todo_list/controllers/keys.dart';
import 'package:todo_list/controllers/my_keys_controller.dart';
import 'package:todo_list/data/utils.dart';

class GenerateKeys extends StatefulWidget {
  const GenerateKeys({super.key});

  @override
  State<GenerateKeys> createState() => _GenerateKeys();
}

class _GenerateKeys extends State<GenerateKeys> {
  final TextEditingController _privateKeyController = TextEditingController();
  final TextEditingController _publicKeyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final dbHelper = MyKeysHelper();

  

  void saveKeys() async {
    if (_privateKeyController.text == "" ||
        _publicKeyController.text == "" ||
        _nameController.text == "") {
        exibirDialogoDeAviso(context, const Text("Erro!"),
          const Text("Gere as chaves e escolha um nome para guarda-las"), const Text("ok"));
      return;
    }
    if (_nameController.text == "-Chaves-") {
      exibirDialogoDeAviso(context, const Text("Erro!"),
          const Text("Nome inválido"), const Text("ok"));
      return;
    }
    var item = {
      "name": _nameController.text,
      "privateKey": _privateKeyController.text,
      "publicKey": _publicKeyController.text
    };
    var result = await dbHelper.insertItem(item);
    if (result != 0) {
      exibirDialogoDeAviso(context, const Text("Sucesso!"),
      const Text("Chaves guardadas com sucesso!"), const Text("ok"));
    } else {
      exibirDialogoDeAviso(context, const Text("Erro na criação!"),
      const Text("Nome já existe no banco!"), const Text("ok"));
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
                  constraints: const BoxConstraints.tightFor(width: 30, height: 40),
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
                  constraints: const BoxConstraints.tightFor(width: 30, height: 40),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    copyText(_publicKeyController.text, context);
                  },
                  icon: const Icon(Icons.copy, size: 20)
              )
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
          LabeledTextField(
            controller: _nameController,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "Identificador das chaves",
            maxLines: 1,
            contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  
                  onPressed: () {
                    var key = generateKeys();
                    setState(() {
                      _privateKeyController.text = key.toHex();
                      _publicKeyController.text = key.publicKey.toHex();
                    });
                  },
                  child: Text(
                    "Gerar chaves",
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
              ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () async {
                    saveKeys();
                    //await deleteDatabaseFile();
                  },
                  child: Text(
                    "Guardar chaves",
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}


