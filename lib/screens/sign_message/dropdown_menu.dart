import 'package:crypto_id/controllers/my_keys_controller.dart';
import 'package:crypto_id/screens/sign_message/key_change_notifier.dart';
import 'package:flutter/material.dart';

class DropDownMyKeys extends StatefulWidget {

  DropDownMyKeys({
    super.key,
    required this.keyChangeNotifier,
    required this.keysRegistered
  });

  final KeyChangeNotifier keyChangeNotifier;
  final List<MyKey> keysRegistered;

  @override
  State<DropDownMyKeys> createState() => _DropDownMyKeysState();
}

class _DropDownMyKeysState extends State<DropDownMyKeys> {
  final dropDownController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownMenu<MyKey>(
            initialSelection: null,
            label: Text(
              "Selecione uma chave",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            textStyle: Theme.of(context).textTheme.displayMedium,
            controller: dropDownController,
            width: MediaQuery.of(context).size.width-40,
            enableFilter: false,
            enableSearch: false,
            requestFocusOnTap: true,
            onSelected: (MyKey? key) {
              widget.keyChangeNotifier.setkeys(key!);
              setState(() {});
            },
            dropdownMenuEntries:
                widget.keysRegistered.map<DropdownMenuEntry<MyKey>>((MyKey key) {
              return DropdownMenuEntry<MyKey>(
                value: key,
                label: key.name,
                style: MenuItemButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.displayMedium,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
