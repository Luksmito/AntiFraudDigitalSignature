import 'package:crypto_id/components/image_with_title.dart';
import 'package:flutter/material.dart';

class SignMessageTutorial extends StatelessWidget {
  const SignMessageTutorial({super.key});

  final String text1 =
      "Agora você irá aprender como assinar uma mensagem, você deve assinar uma mensagem para provar para alguém que realmente foi você que fez isso";
  final String text2 =
      "1 - Primeiramente escolha seu par de\nchaves:";
  final String text3 = 
      "2 - Você pode copiar sua chave pública para enviar para alguém: ";
  final String text4 = 
      "3 - Aqui você pode escrever a mensagem que deseja assinar ou pode deixar a mensagem padrão:";
  final String text5 = 
      "4 - Agora clique em assinar mensagem e depois copie a mensagem assinada:";

  final String text6 = 
      "Com essa assinatura em mãos outras pessoas, em posse de sua chave pública podem verificar sua identidade";


  @override 
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
          const SizedBox(height: 20),
        ImageWithTitle(
          texto: text2, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/escolhaUmaChave.jpeg",
        ),
        const SizedBox(height: 20),
        ImageWithTitle(
          texto: text3, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/camposChavesEditado.jpg",
        ),
        const SizedBox(height: 20),
        ImageWithTitle(
          texto: text4, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/teste.jpeg" 
        ),
        const SizedBox(height: 20),
        ImageWithTitle(
          texto: text5, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/assinarMensagemEditado.jpg"
        ),
        const SizedBox(height: 20),
        Text(text6, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
        const SizedBox(height: 20),
        ],
      ),
    );
  }
}