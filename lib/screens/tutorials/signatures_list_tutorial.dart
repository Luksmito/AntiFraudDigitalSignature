import 'package:crypto_id/components/image_with_title.dart';
import 'package:flutter/material.dart';

class SignaturesListTutorial extends StatelessWidget {
  const SignaturesListTutorial({super.key});

   final String text1 =
      "Nesta tela aparecem as assinaturas de outras pessoas que você cadastrou.";
  final String text2 =
      "1 - Nesse card você pode verificar a validade da assinatura de alguém:";
  final String text3 = 
      "2 - Cole a assinatura que a pessoa te enviou nesse campo:";
  final String text4 = 
      "3 - Cole a mensagem que ela assinou ou deixe assim se ele tiver assinado a mensagem padrão";
  final String text5 = 
      "4 - Agora clique aqui e verifique a assinatura:";
  final String text6 = 
      "5 - Agora aparecerá uma mensagem que diz se a assinatura é válida ou não";

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
        ImageWithTitle(
          texto: text4, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/addpk.jpg",
        ),
        const SizedBox(height: 20),
      ],),
    );
  } 

}