import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/StoresScreenTabs/FavoriteTab/FavoriteTab.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/MapTab.dart';
import 'package:shopisan/components/StoresScreenTabs/PostsTab/PostsTab.dart';
import 'package:shopisan/components/StoresScreenTabs/SettingsTab/SettingsTab.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/StoreListTab.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/loading_indicator.dart';

class StoresScreen extends StatefulWidget {
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  int _currentIndex = 0;
  String latitudeData;
  String longitudeData;
  List<Store> stores = [];
  List<Post> posts = [];
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getting location");
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(geoposition);
    setState(() {
      latitudeData = "${geoposition.latitude}";
      longitudeData = "${geoposition.longitude}";
    });

    // @todo il faudrait sauvegarder la dernière location dans le storage de l'appareil en DB :D
    loadStores();

    prefs.setString(
        'last_geolocation',
        json.encode({
          "latitude": geoposition.latitude,
          "longitude": geoposition.longitude
        }));
  }

  void loadStores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("Latitude: $latitudeData, Longitude: $longitudeData");

    List<Store> storeList =
        await fetchStores(selectedCategoriesId, latitudeData, longitudeData);

    setState(() {
      stores = storeList;
    });

    // prefs.setString('last_stores', json.encode(storeList));
  }

  void getOldPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('last_geolocation')) {
      var geoloc = json.decode(prefs.getString('last_geolocation'));
      print("geoloc: $geoloc");
      setState(() {
        latitudeData = "${geoloc['latitude']}";
        longitudeData = "${geoloc['longitude']}";
      });
    }
  }

  void getOldStores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('last_stores')) {
      var lesStores = json.decode(prefs.getString('last_stores'));
      setState(() {
        stores = lesStores;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getOldPosition();
    getOldStores();
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
        // icon: SvgPicture.asset(storeIcon),
        icon: Icon(Icons.store_outlined, size: 40),
        label: ("Store"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        // icon: SvgPicture.asset(mapIcon),
        icon: Icon(Icons.map_outlined, size: 40),
        label: ("Map"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_outlined, size: 40),
        label: ("Favorite"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined, size: 40),
        label: "Profile",
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
      FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("posts $posts");
            return PostsTab(posts: snapshot.data, stores: stores);
          }
          return LoadingIndicator();
        },
        future: getPosts(),
      ),
      StoreListTab(
        setSelectedCats: setSelectedCats,
        stores: stores,
      ),
      MapTab(
        stores: stores,
        latitude: double.parse(latitudeData),
        longitude: double.parse(longitudeData),
      ),
      FavoriteTab(),
      SettingsTab(),
    ];

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
        ),
      ),
    );
  }
}
