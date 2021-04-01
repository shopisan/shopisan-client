import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DescriptionTabCommercial/DescriptionTabCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DetailsCommercialScreenTab/CategoriesCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DetailsCommercialScreenTab/RatingBarCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/MapTabCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/PostsTabCommercial/PostsTabCommercial.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/OpeningTime.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/theme/colors.dart';

class StoreDetailScreen extends StatefulWidget {
  const StoreDetailScreen({Key key, @required this.storeId}) : super(key: key);

  final int storeId;

  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  Store store;
  AddressCollection addresses;
  List<Category> categories;
  OpeningTime openingTime;

  int _currentIndex = 0;

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        backgroundColor: Colors.white,
        icon: Icon(Icons.store_outlined, size: 40),
        label: ("About"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.newspaper, size: 40),
        label: ("Posts"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map_outlined, size: 40),
        label: ("Map"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
    ];
  }

  Future<Store> getStore() async {
    final response = await http.get(
        Uri.http("10.0.2.2:8000", "/api/stores/stores/${widget.storeId}/"),
        headers: {'Accept': 'application/json'});
    try {
      if (response.statusCode == 200) {
        return Store.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      print("Oops: $Exception");
    }
    return null;
  }

  void getCategories() async {
    List<Category> categoryList = await fetchCategories();

    setState(() {
      categories = categoryList;
    });
  }

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _getListTab(Store store) {
    return <Widget>[
      DescriptionTabCommercial(
        store: store,
        openingTime: openingTime,
      ),
      PostsTabCommercial(),
      // MapTabCommercial(addresses: addresses),
      MapTabCommercial(store: store),
    ];
  }

  @override
  void initState() {
    fetchStore(widget.storeId).then((value) {
      setState(() {
        store = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (null == store) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: CustomColors.commercialBlue,
            iconTheme: IconThemeData(color: Colors.black),
            title: Column(
              children: [
                Text("${store.name}",
                    style: Theme.of(context).textTheme.headline2),
              ],
            ),
            actions: [
              RatingBarCommercial(),
            ]),
        body: SingleChildScrollView(
          child: Container(
            color: CustomColors.commercialBlue,
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  height: 200,
                  width: double.infinity,
                ),
                CategoriesCommercial(
                  store: store,
                ),
                _getListTab(store).elementAt(_currentIndex),
              ],
            ),
          ),
        ),
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
        floatingActionButton: Align(
          child: FloatingActionButton(
            backgroundColor: CustomColors.iconsFaded,
            child: Icon(Icons.favorite),
            onPressed: () async {
              try {
                UserProfile user = await manageFavouriteStore(store.id);
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(UserChangedEvent(user: user));
              } catch (exception) {
                print("Oops, error during handling favourite store adding");
              }
            },
          ),
          alignment: Alignment(1, -0.2),
        ),
      ),
    );
  }
}
