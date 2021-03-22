import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shopisan/components/CommercialScreenTab/DescriptionTabCommercial/DescriptionTabCommercial.dart';
import 'package:shopisan/components/CommercialScreenTab/DetailsCommercialScreenTab/CategoriesCommercial.dart';
import 'package:shopisan/components/CommercialScreenTab/DetailsCommercialScreenTab/RatingBarCommercial.dart';
import 'package:shopisan/components/CommercialScreenTab/MapTabCommercial.dart';
import 'package:shopisan/components/CommercialScreenTab/PostsTabCommercial/PostsTabCommercial.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/theme/icons.dart';

class CommercialScreen extends StatefulWidget {
  const CommercialScreen({Key key, @required this.storeId}) : super(key: key);

  final int storeId;

  @override
  _CommercialScreenState createState() => _CommercialScreenState();
}

class _CommercialScreenState extends State<CommercialScreen> {
  Store store;
  AddressCollection addresses;
  CategoryCollection categories;

  int _currentIndex = 0;

  static List<Widget> _tabs = <Widget>[
    DescriptionTabCommercial(),
    PostsTabCommercial(),
    // MapTabCommercial(addresses: addresses),
    MapTabCommercial(),
  ];

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        backgroundColor: Colors.white,
        icon: SvgPicture.asset(storeIcon),
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
        icon: SvgPicture.asset(mapIcon),
        label: ("Map"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
    ];
  }

  // ignore: missing_return
  Future<Store> getStore() async {
    final response = await http.get(
        Uri.http("10.0.2.2:8000", "/api/stores/stores/${widget.storeId}/"),
        headers: {'Accept': 'application/json'});
    try {
      if (response.statusCode == 200) {
        store = Store.fromJson(json.decode(response.body));
        print("store: $store");
        return store;
      }
    } catch (Exception) {
      print("Oops: $Exception");
    }
  }

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: CustomColors.commercialBlue,
            iconTheme: IconThemeData(color: Colors.black),
            title: FutureBuilder<Store>(
              future: getStore(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final store = snapshot.data;
                  return Column(
                    children: [
                      Text(
                          // AppLocalizations.of(context).commercialName,
                          "${store.name}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error", style: TextStyle(color: Colors.black));
                }

                return CircularProgressIndicator();
              },
            ),
            actions: [
              RatingBarCommercial(),
            ]),
        body: Container(
          color: CustomColors.commercialBlue,
          child: Column(
            children: [
              Container(
                // todo image commerce : pouvoir en afficher plusieurs en scroll horizontal ?
                color: Colors.black,
                height: 200,
                width: double.infinity,
              ),
              CategoriesCommercial(categories: categories),
              _tabs.elementAt(_currentIndex),
            ],
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
      ),
    );
  }
}
