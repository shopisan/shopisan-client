import 'dart:convert';

// import 'package:facebook_app_events/facebook_app_events.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
// import 'package:app_tracking_transparency/app_tracking_transparency.dart';

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
  // static final facebookAppEvents = FacebookAppEvents();
  // final FirebaseAnalytics _analytics = FirebaseAnalytics();

  // Future<void> initPlugin() async {
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   final TrackingStatus status =
  //     await AppTrackingTransparency.trackingAuthorizationStatus;
  //   // If the system can show an authorization request dialog
  //   if (status == TrackingStatus.notDetermined) {
  //     // Show a custom explainer dialog before the system dialog
  //     if (await showCustomTrackingDialog(context)) {
  //       // Wait for dialog popping animation
  //       await Future.delayed(const Duration(milliseconds: 200));
  //       // Request system's tracking authorization dialog
  //       final TrackingStatus status =
  //         await AppTrackingTransparency.requestTrackingAuthorization();
  //     }
  //   }
  //
  //   final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  //   if(status == TrackingStatus.notDetermined && uuid != "00000000-0000-0000-0000-000000000000"){
  //     print("Allow tracking");
  //     // facebookAppEvents.setAdvertiserTracking(enabled: true);
  //     _analytics.setAnalyticsCollectionEnabled(true);
  //   }
  //   print("UUID: $uuid");
  // }

  // Future<bool> showCustomTrackingDialog(BuildContext context) async =>
  //     await showDialog<bool>(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text(AppLocalizations.of(context)!.dearUser),
  //         content: Text(
  //             AppLocalizations.of(context)!.trackingNotice
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context, false),
  //             child: Text(AppLocalizations.of(context)!.chooseLater),
  //           ),
  //           TextButton(
  //             onPressed: () => Navigator.pop(context, true),
  //             child: Text(AppLocalizations.of(context)!.allowTracking),
  //           ),
  //         ],
  //       ),
  //     ) ??
  //         false;

  void setSelectedCats(List<dynamic> selectedCats) async {
    // print("selected cats: " + selectedCats.toString());
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
    double latitude = 48.864716;
    double longitude = 2.349014;

    try {
      final geoposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      print(geoposition);
      print(geoposition.latitude);
      print(geoposition.longitude);

      latitude = geoposition.latitude;
      longitude = geoposition.longitude;
    } catch (exception) {

    }

    List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude, longitude, localeIdentifier: "en");

    String currentCountry = placemarks[0].isoCountryCode!;

    setState(() {
      latitudeData = latitude;
      longitudeData = longitude;
      myLatitude = latitude;
      myLongitude = longitude;
      country = currentCountry;
    });

    loadCities();
    loadStores();
    prefs.setString(
        'last_geolocation',
        json.encode({
          "latitude": latitude,
          "longitude": longitude,
          "country": country
        })
    );
  }

  void loadStores() async {
    setState(() {
      loading = true;
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Store> storeList1 = await fetchStores("featured",
        selectedCategoriesId, latitudeData!, longitudeData!, country);
    setState(() {
      stores = storeList1;
      loading = false;
    });

    List<Store> storeList2 = await fetchStores("customised",
        selectedCategoriesId, latitudeData!, longitudeData!, country);
    setState(() {
      stores = [...storeList1, ...storeList2];
      loading = false;
    });

    List<Store> storeList3 = await fetchStores("",
        selectedCategoriesId, latitudeData!, longitudeData!, country);

    List<Store> storeList = [...storeList1, ...storeList2, ...storeList3];

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

    // WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
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
