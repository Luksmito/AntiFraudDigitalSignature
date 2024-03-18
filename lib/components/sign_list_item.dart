import 'package:flutter/material.dart';
import 'package:todo_list/controllers/other_keys_controller.dart';
import '../data/people.dart';
import '../data/styles.dart';
import 'package:todo_list/components/labeled_text_field.dart';

class SignListItem extends StatefulWidget {
  final OtherKeys people;
  const SignListItem({super.key, required this.people});
  
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
          color: Theme.of(context).colorScheme.primary,
          width: 0.3
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
          children: [
            LabelSignListItem(widget: widget),
            const PairTextFieldButtonSignListItem(),
          ],
      ),
    );
    

  }
}

class PairTextFieldButtonSignListItem extends StatelessWidget {
  const PairTextFieldButtonSignListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 10),
      child: Column(
        children: [
            LabeledTextField(
              textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              labelText: "",
              innerText: "Assinatura",
              contentPadding: const EdgeInsets.fromLTRB(10,0,0,0),
            ),
          const SizedBox(
            height: 25,
          ),
          LabeledTextField(
            textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
            labelText: "",
            innerText: "Mensagem",
            contentPadding: const EdgeInsets.all(10),
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
                  print("TEST");
                }, 
                child: Text(
                  "Verificar assinatura", 
                  style: Theme.of(context).textTheme.labelLarge,
                ) 
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//Classe que representa a parte que contem o Nome e o icone de delete
class LabelSignListItem extends StatelessWidget {
  const LabelSignListItem({
    super.key,
    required this.widget,
  });

  final SignListItem widget;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(            
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 0.3
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left:10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.people.name, style: Theme.of(context).textTheme.labelSmall),
              const Spacer(),
              Icon(Icons.delete, color:Theme.of(context).colorScheme.onSecondary,),
            ],
            
          ),
        ),
      ),
    );
  }
}