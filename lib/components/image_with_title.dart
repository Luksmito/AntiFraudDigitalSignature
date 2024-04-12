import 'package:flutter/material.dart';

class ImageWithTitle extends StatelessWidget {
  
  final String texto;
  final TextStyle textStyle;
  final String imagePath;
  
  const ImageWithTitle({super.key, required this.texto, required this.textStyle, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(texto, style: textStyle),
        const SizedBox(height: 20,),
        Image.asset(imagePath)
      ],
    );
  }
}
        
          