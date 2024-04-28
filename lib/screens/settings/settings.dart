import 'package:crypto_id/screens/settings/manage_my_keys.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/components/screen_title.dart';

/// Flutter code sample for [CheckboxListTile].

class Settings extends StatefulWidget {
  const Settings(
      {super.key,
      required this.changeThemeCallback,
      required this.actualThemeMode});

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: const Row(children: [ SizedBox(width: 20,),  ScreenTitle(title: "Configurações"),],),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.pop(context);
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 0.5),
            ),
              child: Hero(
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
                      subtitle: Text('Mude para o modo noturno', style: Theme.of(context).textTheme.displaySmall,),
                      tileColor: Theme.of(context).colorScheme.onSecondary,
                      onTap: () {})
              ),
            ),
            const ManageMyKeys()
            
          ],
        ),
      ),
    );
  }
}
