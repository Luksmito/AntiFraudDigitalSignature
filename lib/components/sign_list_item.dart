import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/keys.dart';
import 'package:crypto_id/controllers/other_keys_controller.dart';
import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/data/utils.dart';

class SignListItem extends StatefulWidget {
  final OtherKeys people;
  final void Function(int) deleteCallback;

  const SignListItem(
      {super.key, required this.people, required this.deleteCallback});

  @override
  State<SignListItem> createState() => _SignListItem();
}

class _SignListItem extends State<SignListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      height: 220,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        border: Border.all(
            color: Theme.of(context).colorScheme.primary, width: 0.3),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          LabelSignListItem(
              widget: widget, deleteCallback: widget.deleteCallback),
          PairTextFieldButtonSignListItem(people: widget.people),
        ],
      ),
    );
  }
}

class PairTextFieldButtonSignListItem extends StatefulWidget {
  final OtherKeys people;
  const PairTextFieldButtonSignListItem({super.key, required this.people});

  @override
  State<PairTextFieldButtonSignListItem> createState() =>
      _PairTextFieldButtonSignListItemState();
}

class _PairTextFieldButtonSignListItemState
    extends State<PairTextFieldButtonSignListItem> {
  final TextEditingController _signController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Color colorMessage = Colors.blueGrey;
  String padrao = "Mensagem Padrao";
  String mensagem = "";
  void changeMessageColorAndEraseStandardMessage(String? a) {
    setState(() {
      colorMessage = Theme.of(context).colorScheme.onPrimary;
      _messageController.text = "";
      padrao = "";
    });
  }

  void confirmSignature() {
    var assinatura = _signController.text;
    Signature assinaturaObjeto;
    try {
      assinaturaObjeto = Signature.fromCompactHex(assinatura);
    } catch (e) {
      exibirDialogoDeAviso(
        context,
        Text(
          "Erro!",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          "Assinatura invalida",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          "Ok",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      );
      return;
    }

    bool verificacao = verifySignature(
      assinaturaObjeto,
      PublicKey.fromHex(getP256(), widget.people.publicKey),
      message: _messageController.text,
    );

    if (verificacao) {
      exibirDialogoDeAviso(
        context,
        Text(
          "Sucesso!",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          "Assinatura válida",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          "Ok",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      );
    } else {
      exibirDialogoDeAviso(
        context,
        Text(
          "Erro!",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          "Assinatura invalida",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          "Ok",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _messageController.text = padrao;
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 10),
      child: Column(
        children: [
          LabeledTextField(
              controller: _signController,
              textStyle: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              labelText: "",
              innerText: "Assinatura",
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              onTap: () {
                showMenuToPasteText(context, _signController);
              }),
          const SizedBox(
            height: 25,
          ),
          LabeledTextField(
            onEditingComplete: () {
              if (mensagem == "") {
                _messageController.text = padrao;
              }
            },
            onTap: () {
              changeMessageColorAndEraseStandardMessage("");
              showMenuToPasteText(context, _messageController, offset: 55);
              mensagem = _messageController.text;
            },
            controller: _messageController,
            textStyle: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
            labelText: "",
            innerText: "Mensagem",
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    confirmSignature();
                  },
                  child: Text(
                    "Verificar assinatura",
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class LabelSignListItem extends StatelessWidget {
  final void Function(int) deleteCallback;
  final SignListItem widget;

  const LabelSignListItem(
      {super.key, required this.widget, required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
            color: Theme.of(context).colorScheme.primary, width: 0.3),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.people.name,
                  style: Theme.of(context).textTheme.labelSmall),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  var confirm = await exibirDialogoDeConfirmacao(
                      context,
                      Text("Deletar?",
                          style: Theme.of(context).textTheme.displayLarge),
                      Text("Tem certeza que quer deletar essa assinatura?",
                          style: Theme.of(context).textTheme.labelMedium));
                  if (confirm != null && confirm) {
                    deleteCallback(widget.people.id);
                  }
                },
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
