
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends CupertinoTabBar {
  /// NavBar для страниц из [CupertinoTabView] на [HomeScreen]
  NavBar({super.key,
    required ValueChanged<int> onTab,
  }) : super(
    onTap: onTab,
    items: [
     const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Учет",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.production_quantity_limits),
        label: "Заказы",
      ),

      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Профайл",
      ),


    ],
    border: const Border(
      top: BorderSide(color: Colors.black38, width: 0.7),
    ),
    backgroundColor: Colors.white,
  );
}