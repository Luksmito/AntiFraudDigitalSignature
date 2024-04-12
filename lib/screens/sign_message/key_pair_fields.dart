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
          LabeledTextField(
            obscureText: isPressedEye1,
            controller: privateKeyTextController,
            readOnly: true,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "",
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chave pública",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              IconButton(
                  splashColor: Colors.transparent,
                  constraints:
                      const BoxConstraints.tightFor(width: 15, height: 15),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    copyText(publicKeyTextController.text, context);
                  },
                  icon: const Icon(Icons.copy, size: 20)),
            ],
          ),
          LabeledTextField(
            controller: publicKeyTextController,
            readOnly: true,
            textStyle: Theme.of(context).textTheme.displayMedium,
            labelText: "",
            maxLines: 7,
            height: 77,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ]);
  }
}
