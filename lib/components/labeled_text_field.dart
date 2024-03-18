import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/data/styles.dart';

class LabeledTextField extends StatelessWidget {

  final EdgeInsets contentPadding;
  final double height;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final bool autoCorrect;
  final String labelText;
  final String innerText;
  final int maxLines;
  final bool readOnly;
  final TextEditingController? controller;
  final bool obscureText;

  const LabeledTextField({
    super.key,
    this.textStyle = const TextStyle(),
    this.height = 30,
    this.autoCorrect = false,
    this.innerText = '',
    this.labelText = '',
    this.maxLines = 1,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 0.5, horizontal: 2),
    this.labelStyle = const TextStyle(),
    this.readOnly = false,
    this.controller,
    this.obscureText = false
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != "")
          Text(labelText, style:  textStyle,),
        if (labelText != "")
          const SizedBox(height: 7,),
        SizedBox(
          height: height,
          child: TextField(
                obscureText: obscureText,
                controller: controller,
                readOnly: readOnly,
                maxLines: maxLines,
                style: textStyle,
                autocorrect: autoCorrect,
                decoration: InputDecoration(
                labelText: innerText,
                labelStyle: textStyle,
                contentPadding: contentPadding,
                border: const OutlineInputBorder()
              ),
            ),
        ),
      ],
    );
  }
}
