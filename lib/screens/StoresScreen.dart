import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shopisan/components/StoresScreenTabs/FavoriteTab/FavoriteTab.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/MapTab.dart';
import 'package:shopisan/components/StoresScreenTabs/SettingsTab/SettingsTab.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/StoreListTab.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Country.dart';
import 'package:shopisan/model/City.dart';
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
  late double? latitudeData;
  double? longitudeData;
  double? myLatitude;
  double? myLongitude;
  List<Store> stores = [];
  List<Post> posts = [];
  List<Category> categories = [];
  List<Country> countries = [];
  List<dynamic> selectedCategoriesId = [];
  List<dynamic> history = [];
  String country = "BE";
  List<City> cities = [];
  int city = 0;
  bool loading = false;

  void setSelectedCats(List<dynamic> selectedCats) async {
    print("selected cats: " + selectedCats.toString());
    setState(() {
      selectedCategoriesId = selectedCats;
    });
    loadStores();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('search_history')) {
      history = jsonDecode(prefs.getString("search_history")!);
      for (dynamic id in selectedCats) {
        history.remove(id);
      }
    }

    for (dynamic id in selectedCats) {
      history.add(id);
    }

    setState(() {
      history = history;
    });

    prefs.setString('search_history', json.encode(history));
  }

  void setCountry(Object? selectCountry) async {
    if (selectCountry is String) {
      setState(() {
        country = selectCountry;
      });

      loadCities();
      loadStores();
    }
  }

  void loadCities() async {
    List<City> lesCities = await fetchCities(country);
    setState(() {
      cities = lesCities;
    });
  }

  void setCity(Object? selectedCity) async {
    City? theCity;

    if (selectedCity is int) {
      if (selectedCity == 0) {
        setState(() {
          city = 0;
          latitudeData = myLatitude!;
          longitudeData = myLongitude!;
        });
      } else {
        for (City city in cities) {
          if (city.id == selectedCity) {
            theCity = city;
          }
        }

        setState(() {
          city = theCity!.id!;
          latitudeData = theCity.latitude!;
          longitudeData = theCity.longitude!;
        });
      }

      loadStores();
    }
  }

  // Récupérer la géolocalisation
  getCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // GeoCode geoCode = GeoCode();
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        geoposition.latitude, geoposition.longitude);

    String currentCountry = placemarks[0].isoCountryCode!;

    setState(() {
      latitudeData = geoposition.latitude;
      longitudeData = geoposition.longitude;
      myLatitude = geoposition.latitude;
      myLongitude = geoposition.longitude;
      country = currentCountry;
    });

    loadCities();

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
        selectedCategoriesId, latitudeData!, longitudeData!, country);

    setState(() {
      stores = storeList;
      loading = false;
    });

    // prefs.setString('last_stores', json.encode(storeList));
  }

  void getOldPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('last_geolocation')) {
      var geoloc = json.decode(prefs.getString('last_geolocation')!);

      setState(() {
        latitudeData = geoloc['latitude'];
        longitudeData = geoloc['longitude'];
        myLatitude = geoloc['latitude'];
        myLongitude = geoloc['longitude'];
        country = geoloc.containsKey('country') ? geoloc['country'] : null;
      });
    }
  }

  void getOldStores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('last_stores')) {
      var lesStores = json.decode(prefs.getString('last_stores')!);
      setState(() {
        stores = lesStores;
      });
    }
  }

  void getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('search_history')) {
      setState(() {
        history = jsonDecode(prefs.getString("search_history")!);
      });
    }
  }

  void getCategories() async {
    var catTemp = fetchCategories();
    var countriesQuery = fetchCountries();
    List<Category> catColl = await catTemp;
    List<Country> countriesTemp = await countriesQuery;

    setState(() {
      categories = catColl;
      countries = countriesTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    latitudeData = 0;
    longitudeData = 0;
    getOldPosition();
    getOldStores();
    getCurrentLocation();
    getSearchHistory();
    getCategories();
    // loadCities();
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
        label: AppLocalizations.of(context)!.store,
      ),
      BottomNavigationBarItem(
        // icon: SvgPicture.asset(mapIcon),
        // icon: Icon(Icons.map_outlined, size: 30),
        icon: FaIcon(
          FontAwesomeIcons.mapMarker,
          size: 30,
        ),
        label: AppLocalizations.of(context)!.map,
      ),
      BottomNavigationBarItem(
        // icon: Icon(Icons.favorite_border_outlined, size: 30),
        icon: FaIcon(
          FontAwesomeIcons.solidHeart,
          size: 30,
        ),
        label: AppLocalizations.of(context)!.fav,
      ),
      BottomNavigationBarItem(
        // icon: Icon(Icons.account_circle_outlined, size: 30),
        icon: FaIcon(
          FontAwesomeIcons.solidUser,
          size: 30,
        ),
        label: AppLocalizations.of(context)!.profile,
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
          selectedCountry: country,
          setCountry: setCountry,
          selectedCity: city,
          setCity: setCity,
          cities: cities,
          loading: loading,
          categories: categories,
          countries: countries,
      ),
      MapTab(
          stores: stores,
          latitude: latitudeData!,
          longitude: longitudeData!,
          selectedCountry: country,
          setCountry: setCountry,
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
