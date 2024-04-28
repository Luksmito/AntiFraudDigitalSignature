import 'package:crypto_id/components/label_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:crypto_id/components/labeled_text_field.dart';

class KeyPairFields extends StatefulWidget {
  final String privateKeyText;
  final String publicKeyText;

  const KeyPairFields({super.key, required this.privateKeyText, required this.publicKeyText});

  @override
  State<KeyPairFields> createState() => _KeyPairFieldsState();
}

class _KeyPairFieldsState extends State<KeyPairFields> {
  bool isPressedEye1 = true;
  var privateKeyTextController = TextEditingController();
  var publicKeyTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    privateKeyTextController.text = widget.privateKeyText;
    publicKeyTextController.text = widget.publicKeyText;
    return  Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chave privada",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              IconButton(
                constraints:
                      const BoxConstraints.tightFor(width: 15, height: 15),
                color: Theme.of(context).colorScheme.primary,
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    isPressedEye1 = !isPressedEye1;
                  });
                },
                icon: isPressedEye1
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              IconButton(
                
                  splashColor: Theme.of(context).colorScheme.onSecondary,
                  constraints:
                      const BoxConstraints.tightFor(width: 15, height: 15),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: 20,
                  onPressed: () {
                    copyText(privateKeyTextController.text, context);
                  },
                  icon: const Icon(Icons.copy)),
            ],
          ),
          const SizedBox(height: 5,),
          LabeledTextField(
            obscureText: isPressedEye1,
            controller: privateKeyTextController,
            contentPadding: const EdgeInsets.all(10),
            readOnly: true,
            textStyle: Theme.of(context).textTheme.displaySmall,
             height: 64,
            labelText: "",
          ),
         LabelWIthIcon(controllerToCopy: publicKeyTextController, label: "Chave pública"),
          const SizedBox(height: 5,),
          LabeledTextField(
            controller: publicKeyTextController,
            readOnly: true,
            textStyle: Theme.of(context).textTheme.displaySmall,
            labelText: "",
            maxLines: 7,
            height: 80,
            contentPadding: const EdgeInsets.all(20),
          ),
        ]);
  }
}
