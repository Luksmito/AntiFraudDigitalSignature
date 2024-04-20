import 'package:flutter/material.dart';
import 'package:crypto_id/data/utils.dart';


class LabelWIthIcon extends StatelessWidget {
  
  const LabelWIthIcon({
    super.key,
    required TextEditingController controllerToCopy,
    required String label
  }) : _controllerToCopy = controllerToCopy, _label = label;

  final TextEditingController _controllerToCopy;
  final String _label;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _label,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        IconButton(
            constraints:
                const BoxConstraints.tightFor(width: 15, height: 15),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              copyText(_controllerToCopy.text, context);
            },
            icon: const Icon(Icons.copy, size: 20))
      ],
    );
  }
}
