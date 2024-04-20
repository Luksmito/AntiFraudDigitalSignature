import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ButtonWithShowcase extends StatelessWidget {

  ButtonWithShowcase({
    super.key,
    required this.showcaseKey, 
    required this.description,
    required this.title,
    required this.onPressed,
    required this.buttonText
  });
  
  final GlobalKey showcaseKey;
  final String description;
  final String title;
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: showcaseKey,
      description: description,
      title: title,
      child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.labelLarge,
          )),
    );
  }
}