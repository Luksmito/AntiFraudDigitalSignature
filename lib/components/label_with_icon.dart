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
    return Container(
      constraints: const BoxConstraints.tightFor(height: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _label,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          IconButton(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              constraints:
                  const BoxConstraints.tightFor(width: 15, height: 15),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                copyText(_controllerToCopy.text, context);
              },
              icon: const Icon(Icons.copy, size: 20))
        ],
      ),
    );
  }
}
