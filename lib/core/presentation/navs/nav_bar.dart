
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
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.production_quantity_limits),
        label: "Products",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: "Favorites",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.card_giftcard),
        label: "Cards",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings",
      ),


    ],
    border: const Border(
      top: BorderSide(color: Colors.black38, width: 0.7),
    ),
    backgroundColor: Colors.white,
  );
}