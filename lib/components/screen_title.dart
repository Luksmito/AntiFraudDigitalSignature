import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;

  const ScreenTitle(
    {
      super.key,
      this.title = ""
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Text(title, style: Theme.of(context).textTheme.displayLarge,),],),
          const SizedBox(height: 20,)
        ]
      ),
    );
  }


}

