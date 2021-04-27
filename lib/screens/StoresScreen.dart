import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/StoresScreenTabs/FavoriteTab/FavoriteTab.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/MapTab.dart';
import 'package:shopisan/components/StoresScreenTabs/SettingsTab/SettingsTab.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/StoreListTab.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class StoresScreen extends StatefulWidget {
  final bool toLogin;

  StoresScreen({this.toLogin = false});

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
  List<dynamic> history = [];
  List<dynamic> countries = [];
  bool loading = false;

  void setSelectedCats(List<dynamic> selectedCats) async {
    setState(() {
      selectedCategoriesId = selectedCats;
    });
    loadStores();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('search_history')) {
      history = jsonDecode(prefs.getString("search_history"));
      for (int id in selectedCats) {
        history.remove(id);
      }
    }

    for (int id in selectedCats) {
      history.add(id);
    }

    setState(() {
      history = history;
    });

    prefs.setString('search_history', json.encode(history));
  }

  void setCountries(List<dynamic> selectCountries) async {
    setState(() {
      countries = selectCountries;
    });
    loadStores();
  }

  // Récupérer la géolocalisation
  getCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates =
        new Coordinates(geoposition.latitude, geoposition.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    String country = addresses.first.countryCode;

    setState(() {
      latitudeData = "${geoposition.latitude}";
      longitudeData = "${geoposition.longitude}";
      countries = [country];
    });

    loadStores();

    prefs.setString(
        'last_geolocation',
        json.encode({
          "latitude": geoposition.latitude,
          "longitude": geoposition.longitude,
          "country": country
        }));
  }

  void loadStores() async {
    setState(() {
      loading = true;
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Store> storeList = await fetchStores(
        selectedCategoriesId, latitudeData, longitudeData, countries);

    setState(() {
      stores = storeList;
      loading = false;
    });

    // prefs.setString('last_stores', json.encode(storeList));
  }

  void getOldPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('last_geolocation')) {
      var geoloc = json.decode(prefs.getString('last_geolocation'));

      setState(() {
        latitudeData = "${geoloc['latitude']}";
        longitudeData = "${geoloc['longitude']}";
        countries = geoloc.containsKey('country') ? [geoloc['country']] : [];
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

  void getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('search_history')) {
      setState(() {
        history = jsonDecode(prefs.getString("search_history"));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getOldPosition();
    getOldStores();
    getCurrentLocation();
    getSearchHistory();
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      // BottomNavigationBarItem(
      //   // icon: Icon(FontAwesomeIcons.newspaper, size: 30),
      //   icon: FaIcon(
      //     FontAwesomeIcons.solidClone,
      //     size: 30,
      //   ),
      //   label: "Posts",
      // ),
      BottomNavigationBarItem(
        // icon: Icon(Icons.store_outlined, size: 30),
        icon: FaIcon(
          FontAwesomeIcons.store,
          size: 30,
        ),
        label: ("Store"),
      ),
      BottomNavigationBarItem(
        // icon: SvgPicture.asset(mapIcon),
        // icon: Icon(Icons.map_outlined, size: 30),
        icon: FaIcon(
          FontAwesomeIcons.mapMarkedAlt,
          size: 30,
        ),
        label: ("Map"),
      ),
      BottomNavigationBarItem(
        // icon: Icon(Icons.favorite_border_outlined, size: 30),
        icon: FaIcon(
          FontAwesomeIcons.solidHeart,
          size: 30,
        ),
        label: ("Favorite"),
      ),
      BottomNavigationBarItem(
        // icon: Icon(Icons.account_circle_outlined, size: 30),
        icon: FaIcon(
          FontAwesomeIcons.solidUser,
          size: 30,
        ),
        label: "Profile",
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
    if (widget.toLogin) {
      _currentIndex = 3;
    }

    List<Widget> _tabs = <Widget>[
      // FutureBuilder(
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return PostsTab(posts: snapshot.data, stores: stores);
      //     }
      //     return LoadingIndicator();
      //   },
      //   future: getPosts(),
      // ),
      StoreListTab(
          setSelectedCats: setSelectedCats,
          stores: stores,
          history: history,
          selectedCats: selectedCategoriesId,
          selectedCountries: countries,
          setCountries: setCountries,
          loading: loading),
      MapTab(
          stores: stores,
          latitude: latitudeData != null ? double.tryParse(latitudeData) : null,
          longitude:
              longitudeData != null ? double.tryParse(longitudeData) : null,
          selectedCountries: countries,
          setCountries: setCountries,
          loading: loading),
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
                spreadRadius: 5,
                blurRadius: 5,
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
