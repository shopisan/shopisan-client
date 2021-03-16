import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///C:/Users/pc/AndroidStudioProjects/shopisan_app/lib/components/CommercialScreenTab/DescriptionTabCommercial/DescriptionTabCommercial.dart';
import 'package:shopisan/components/CommercialScreenTab/DetailsCommercialScreenTab/CategoriesCommercial.dart';
import 'package:shopisan/components/CommercialScreenTab/MapTabCommercial.dart';
import 'file:///C:/Users/pc/AndroidStudioProjects/shopisan_app/lib/components/CommercialScreenTab/PostsTabCommercial/PostsTabCommercial.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/theme/icons.dart';

class CommercialScreen extends StatefulWidget {
  @override
  _CommercialScreenState createState() => _CommercialScreenState();
}

class _CommercialScreenState extends State<CommercialScreen> {

  int _currentIndex = 0;

  static List<Widget> _tabs = <Widget>[
    DescriptionTabCommercial(),
    PostsTabCommercial(),
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
        icon: SvgPicture.asset(postsIcon),
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
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("CITY", style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
            color: Colors.black),
            ),
            Text("Commercial Name", style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ))
          ],
        )
      ),
        body: Container(
          color: CustomColors.commercialBlue,
          child: Column(
            children: [
              Container(
                // image commerce
                color: Colors.black,
                height: 200,
                width: double.infinity,
              ),
              CategoriesCommercial(),
              _tabs.elementAt(_currentIndex),
            ],
          ),
        )  ,
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
