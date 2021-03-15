import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shopisan/components/StoresScreenTabs/FavoriteTab/FavoriteTab.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/MapTab.dart';
import 'package:shopisan/components/StoresScreenTabs/SettingsTab/SettingsTab.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/StoreListTab.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/theme/icons.dart';


class StoresScreen extends StatefulWidget {
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  // todo re-importer les tabs ici
  int _currentIndex = 0;

  static List<Widget> _tabs = <Widget>[
    StoreListTab(),
    MapTab(),
    FavoriteTab(),
    SettingsTab()
  ];

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        backgroundColor: Colors.white,
         icon: SvgPicture.asset(storeIcon),
        label: ("Store"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(mapIcon),
        label: ("Map"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(heartIcon),
        label: ("Favorite"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(settingsIcon),
        label: "Settings",
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
    ];
  }

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // todo style la bottom nav bar
    return SafeArea(
        child: Scaffold(
      appBar: null,
      body: _tabs.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              spreadRadius: 10,
              blurRadius: 30,
              color: CustomColors.spread,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: _navBarsItems(),
          currentIndex: _currentIndex,
          selectedItemColor: CustomColors.iconsActive,
          onTap: _onTapped,
          unselectedItemColor: CustomColors.iconsFaded,
        ),
      )
    ));
  }
}
