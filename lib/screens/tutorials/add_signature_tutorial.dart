import 'package:crypto_id/components/image_with_title.dart';
import 'package:flutter/material.dart';

class AddSignatureTutorial extends StatelessWidget {
  const AddSignatureTutorial({super.key});

   final String text1 =
      "Agora você irá aprender como salvar a assinatura de outra pessoa.";
  final String text2 =
      "1 - Primeiramente escreva o nome que deseja salvar:";
  final String text3 = 
      "2 - Cole a chave pública que recebeu:";
  final String text4 = 
      "Pronto! agora você pode validar a identidade dessa pessoa";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
          const SizedBox(height: 20),
        ImageWithTitle(
          texto: text2, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/addNome.jpg",
        ),
        const SizedBox(height: 20),
        ImageWithTitle(
          texto: text3, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/addpk.jpg",
        ),
        const SizedBox(height: 20),
        Text(text4, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
        const SizedBox(height: 20),
      ],),
    );
  } 

}