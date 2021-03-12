import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shopisan/components/StoresScreenTabs/FavoriteScreen.dart';
import 'package:shopisan/components/StoresScreenTabs/MapScreen.dart';
import 'package:shopisan/components/StoresScreenTabs/SettingsScreen.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListScreen.dart';
import 'package:shopisan/theme/colors.dart';

class StoresScreen extends StatefulWidget {
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  // todo re-importer les tabs ici
  int _currentIndex = 0;

  static List<Widget> _tabs = <Widget> [
    StoreListScreen(),
    MapScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_basket),
        label: ("Store"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: ("Map"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: ("Favorite"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings",
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),

    ];
  }

  void _onTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // todo style la bottom nav bar
    return SafeArea(child: Scaffold(
      appBar: null,
      body: _tabs.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarsItems(),
        currentIndex: _currentIndex,
        selectedItemColor: CustomColors.activePink,
        onTap: _onTapped,
        unselectedItemColor: CustomColors.systemGrey,
      ),
    ));
  }
}

