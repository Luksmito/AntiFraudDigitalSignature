import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  final VoidCallback onExitTutorial;

  const TutorialScreen({required this.onExitTutorial});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 200,),
              Image.asset("lib/assets/images/imagemTutorial.png"),
              Text("Bem-vindo ao", style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 30),),
              const SizedBox(height:5),
              Text("CryptoID", style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 35),),
              const SizedBox(height: 20),
              Text("Proteja a sua identidade digital de ameaças com a nossa tecnologia.", style: Theme.of(context).textTheme.displayMedium,),
              const SizedBox(height: 50,),
              ElevatedButton(
                onPressed: onExitTutorial,
                child: Text('Vamos começar', style: Theme.of(context).textTheme.labelLarge,),
              ),
            ],
          ),
      ),
      );
  }
}
