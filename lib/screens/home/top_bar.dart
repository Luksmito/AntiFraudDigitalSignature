import 'package:flutter/material.dart';

import '../../components/screen_title.dart';


class Bar extends StatelessWidget {
  final String title;
  const Bar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 109, 106, 106), // Cor da linha
              width: 0.4, // Largura da linha
              style: BorderStyle
                  .solid, // Estilo da linha (pode ser solid, dashed, ou none)
            ),
          ),
        ),
        child: ScreenTitle(title: title));
  }
}