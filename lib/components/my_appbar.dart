import 'package:crypto_id/components/screen_title.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
   
   return Row(children: [
            const ScreenTitle(
              title: "Adicionar assinatura",
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute<Widget>(
                      builder: (BuildContext context) {
                    return Placeholder();
                  }));
                },
                icon: const Icon(Icons.help))
          ]);
  }
  
}

