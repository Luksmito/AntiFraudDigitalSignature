import 'package:flutter/material.dart';
import 'package:crypto_id/components/screen_title.dart';
import 'package:crypto_id/data/styles.dart';
import 'package:crypto_id/screens/generate_keys.dart';
import 'package:crypto_id/screens/settings/settings.dart';
import 'package:crypto_id/screens/sign_message/sign_message.dart';
import 'package:crypto_id/screens/signatures_list.dart';
import 'package:crypto_id/screens/add_signature.dart';

int returnIcon(int actualIndex, int myIndex) {
  if (actualIndex == myIndex) {
    return 1;
  } else {
    return 0;
  }
}

class Bar extends StatelessWidget {
  final String title;
  const Bar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
        decoration: const BoxDecoration(
          border:  Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 109, 106, 106), // Cor da linha
              width: 0.4, // Largura da linha
              style: BorderStyle.solid, // Estilo da linha (pode ser solid, dashed, ou none)
            ),
          ),
        ),
        child: ScreenTitle(title: title));
  }
}
class Home extends StatefulWidget {
  Home({super.key, required this.changeThemeCallback, required this.actualThemeMode});
  final List<GlobalKey> tutorialKeys = [GlobalKey(), GlobalKey(), GlobalKey()];
  final Function(bool) changeThemeCallback;
  final ThemeMode actualThemeMode;
  
  @override
  State<Home> createState() => _Home();
}


class _Home extends State<Home> {
  
  int _selectedIndex = 2;

  void changePage(int newIndex){
    setState(() {
      _selectedIndex = newIndex;
    });
  }
  //Lista de páginas de do aplicativos
  
  //Icones para quando a opcao esta selecionada os não selecionada
  static const List<List<Icon>> icones = [
    [Icon(Icons.home_outlined), Icon(Icons.home)],
    [Icon(Icons.add_box_outlined), Icon(Icons.add_box)],
    [Icon(Icons.vpn_key_outlined), Icon(Icons.vpn_key)],
    [Icon(Icons.edit_outlined), Icon(Icons.edit)],
    [Icon(Icons.settings_outlined), Icon(Icons.settings)]
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
 

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      SignaturesList(changePageCallback: changePage,),
      AddSignature(keys: [widget.tutorialKeys[2]]),
      GenerateKeys(changePageCallback: changePage,),
      const SignMessage(),
      Settings(changeThemeCallback: widget.changeThemeCallback, actualThemeMode: widget.actualThemeMode,),
    ];
  
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
      child: widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: icones[0][returnIcon(_selectedIndex, 0)],
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: icones[1][returnIcon(_selectedIndex, 1)],
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: icones[2][returnIcon(_selectedIndex, 2)],
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: icones[3][returnIcon(_selectedIndex, 3)],
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: icones[4][returnIcon(_selectedIndex, 4)],
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
