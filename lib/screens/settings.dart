import 'package:flutter/material.dart';
import 'package:todo_list/components/screen_title.dart';

/// Flutter code sample for [CheckboxListTile].

class Settings extends StatefulWidget {
  const Settings({super.key, required this.changeThemeCallback, required this.actualThemeMode});

  final ThemeMode actualThemeMode;
  final Function(bool) changeThemeCallback;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool light1 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.dark_mode);
      }
      return const Icon(Icons.light_mode);
    },
  );

  @override
  void initState() {
    super.initState();
    light1 = widget.actualThemeMode != ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 20, 36,0),
      child: Column(
        children: <Widget>[
          const ScreenTitle(title: "Configurações"),
          Hero(
              tag: Text(
                "Modo noturno",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              child: ListTile(
                  trailing: Switch(
                    thumbIcon: thumbIcon,
                    value: light1,
                    onChanged: (bool value) {
                      setState(() {
                        light1 = value;
                        widget.changeThemeCallback(light1);
                      });
                    },
                  ),
                  title: Text(
                    "Modo noturno",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  subtitle: const Text('Mude para o modo noturno'),
                  tileColor: Theme.of(context).colorScheme.onSecondary,
                  onTap: () {})),
        ],
      ),
    );
  }
}
