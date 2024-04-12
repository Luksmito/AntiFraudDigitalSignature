import 'package:flutter/material.dart';

//const String text =
//   "Bem-vindo ao CryptoID, seu guarda virtual contra fraudes e garantia de autenticidade. Com este aplicativo, você cria sua própria 'identidade digital' usando um par de chaves única: uma privada e outra pública. A chave privada é sua assinatura digital secreta, enquanto a chave pública permite que outros verifiquem sua autenticidade. Explore nossas telas intuitivas para gerenciar suas chaves, adicionar contatos confiáveis e assinar mensagens com segurança. Com CryptoID, proteja suas comunicações online de forma simples e eficaz.";
const String text = "Bem-vindo ao CryptoID, aqui você pode se proteger contra fraudes de identidade, deixe-me te explicar como";

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Column(children: [
        Text(text, style: Theme.of(context).textTheme.displayMedium),
      ]),
    );
  }
}
