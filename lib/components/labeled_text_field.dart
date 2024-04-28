import 'package:flutter/material.dart';


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
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
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
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.onEditingComplete
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != "")
          Text(labelText, style:  labelStyle,),
        if (labelText != "")
          const SizedBox(height: 7,),
        SizedBox(
          height: height,
          child: TextField(
                onEditingComplete: onEditingComplete,
                obscureText: obscureText,
                controller: controller,
                readOnly: readOnly,
                maxLines: maxLines,
                style: textStyle,
                onChanged: onChanged,
                autocorrect: autoCorrect,
                onTap: onTap,
                decoration: InputDecoration(
                labelText: innerText,
                labelStyle: textStyle,
                contentPadding: contentPadding,
                border: const OutlineInputBorder(
                )
              ),
            ),
        ),
      ],
    );
  }
}
