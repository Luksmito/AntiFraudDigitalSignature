import 'package:flutter/material.dart';
import 'package:crypto_id/data/styles.dart';

class BottomBar extends StatelessWidget {
  
  final int selectedIndex;
  final Function(int) selectIndexCallback;
  BottomBar({super.key, required this.selectedIndex, required this.selectIndexCallback});

  int returnIcon(int actualIndex, int myIndex) {
  if (actualIndex == myIndex) {
    return 1;
  } else {
    return 0;
  }
}

  static const List<List<Icon>> icones = [
    [Icon(Icons.home_outlined), Icon(Icons.home)],
    [Icon(Icons.add_box_outlined), Icon(Icons.add_box)],
    [Icon(Icons.vpn_key_outlined), Icon(Icons.vpn_key)],
    [Icon(Icons.edit_outlined), Icon(Icons.edit)],
    [Icon(Icons.settings_outlined), Icon(Icons.settings)]
  ];
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: icones[0][returnIcon(selectedIndex, 0)],
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: icones[1][returnIcon(selectedIndex, 1)],
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: icones[2][returnIcon(selectedIndex, 2)],
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: icones[3][returnIcon(selectedIndex, 3)],
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: icones[4][returnIcon(selectedIndex, 4)],
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: selectIndexCallback,
      );
  }


}