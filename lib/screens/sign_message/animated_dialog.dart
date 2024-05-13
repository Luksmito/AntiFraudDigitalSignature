import 'package:crypto_id/components/labeled_text_field.dart';
import 'package:crypto_id/data/utils.dart';
import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({super.key, required this.signedMessageController});
  final TextEditingController signedMessageController;
  @override
  State<AnimatedDialog> createState() => _AnimatedDialog();
}

class _AnimatedDialog extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: 250).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      insetPadding: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: animation.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Mensagem Assinada com sucesso!",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Copie o código abaixo para verificar sua assinatura.",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              LabeledTextField(
                controller: widget.signedMessageController,
                readOnly: true,
                textStyle: Theme.of(context).textTheme.displaySmall,
                labelText: "",
                maxLines: 7,
                height: 77,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    copyText(widget.signedMessageController.text, context);
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(251, 44),
                ),
                child: Text(
                  "Copiar o código",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
