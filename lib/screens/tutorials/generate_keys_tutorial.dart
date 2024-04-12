import 'package:crypto_id/components/image_with_title.dart';
import 'package:flutter/material.dart';

//const String text =
//   "Bem-vindo ao CryptoID, seu guarda virtual contra fraudes e garantia de autenticidade. Com este aplicativo, você cria sua própria 'identidade digital' usando um par de chaves única: uma privada e outra pública. A chave privada é sua assinatura digital secreta, enquanto a chave pública permite que outros verifiquem sua autenticidade. Explore nossas telas intuitivas para gerenciar suas chaves, adicionar contatos confiáveis e assinar mensagens com segurança. Com CryptoID, proteja suas comunicações online de forma simples e eficaz.";

class GenerateKeysTutorial extends StatelessWidget {
  const GenerateKeysTutorial({super.key});

  final String text1 =
      "    Neste app você pode provar a sua identidade e verificar a identidade de outras pessoas, como?";
  final String text2 =
      "1 - Primeiramente gere suas \nchaves:";
  final String text3 = 
      "2 - Dê um nome a suas chaves: ";
  final String text4 = 
      "3 - Guarde suas chaves:";
  final String text5 = 
      "4 - (opcional) Copie sua chave \npública para compartilha-la:";

  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Column(
        children: [
        Text(text1, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
        const SizedBox(height: 20),
        ImageWithTitle(
          texto: text2, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/GerarChaves.jpg",
        ),
        const SizedBox(height: 20),
        ImageWithTitle(
          texto: text3, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/nome_exemplo.jpeg",
        ),
        const SizedBox(height: 20),
        ImageWithTitle(
          texto: text4, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/guardar_chaves.jpg" 
        ),
        const SizedBox(height: 20),
        ImageWithTitle(
          texto: text5, 
          textStyle: Theme.of(context).textTheme.displayLarge!, 
          imagePath: "lib/assets/images/copiar_chave_publica_editado.jpg"
        )
      ]),
    );
  }
}
