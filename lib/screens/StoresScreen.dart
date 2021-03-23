import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/StoresScreenTabs/FavoriteTab/FavoriteTab.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/MapTab.dart';
import 'package:shopisan/components/StoresScreenTabs/PostsTab/PostsTab.dart';
import 'package:shopisan/components/StoresScreenTabs/SettingsTab/SettingsTab.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/StoreListTab.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/theme/icons.dart';

class StoresScreen extends StatefulWidget {
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  int _currentIndex = 0;
  String latitudeData;
  String longitudeData;
  List<Store> stores = [];
  List<dynamic> selectedCategoriesId;

  void setSelectedCats(List<dynamic> selectedCats) async {
    setState(() {
      selectedCategoriesId = selectedCats;
    });
    loadStores();

    // @todo ajouter dans categoryHistory (associer par datetime) + save dans storage
  }

  // Récupérer la géolocalisation
  getCurrentLocation() async {
    SharedPreferences prefsLocation = await SharedPreferences.getInstance();
    print("getting location");
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(geoposition);
    setState(() {
      latitudeData = prefsLocation.getString("${geoposition.latitude}");
      longitudeData = prefsLocation.getString("${geoposition.longitude}");
    });
    // @todo il faudrait sauvegarder la dernière location dans le storage de l'appareil en DB :D
    loadStores();
  }

  void loadStores() async {
    Map<String, dynamic> params = {};

    List<Store> storeList =
        await fetchStores(selectedCategoriesId, latitudeData, longitudeData);

    setState(() {
      stores = storeList;
    });
  }

  @override
  void initState() {
    super.initState();
    // @todo récupérer la derniere location ++ afficher les stores
    getCurrentLocation();
    // @todo si des catégories ont été choisies, les enregistrer en DB ++ aller rechercher les infos
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.newspaper, size: 40),
        label: "Posts",
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
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
    List<Widget> _tabs = <Widget>[
      PostsTab(),
      StoreListTab(setSelectedCats: setSelectedCats, stores: stores),
      MapTab(
        stores: stores,
      ),
      FavoriteTab(),
      SettingsTab(),
    ];

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
            )));
  }
}
