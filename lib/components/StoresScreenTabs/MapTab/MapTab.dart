import 'package:flutter/material.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/DetailsMap/GoogleMapScreen.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

import 'DetailsMap/MapItem.dart';

class MapTab extends StatefulWidget {
  const MapTab({Key key, @required this.stores}) : super(key: key);

  final List<Store> stores;

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  List<Store> stores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: GoogleMapScreen(stores: stores),
        ),
        Positioned(
          top: 10,
          right: 15,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Search..."),
              ),
          ),
        ),
        Positioned(
          bottom: 100,
          right: 0,
          child: TextButton(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.iconsActive,
              ),
              child: Icon(
                Icons.location_searching_outlined,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              // @todo plutot replacer la map sur sa position actuelle
            },
          ),
        ),
        // Positioned(
        //   top: 200,
        //   left: 20,r
        //   child: Text("$latitudeData"),
        // ),
        // Positioned(
        //   top: 220,
        //   left: 20,
        //   child: Text("$longitudeData"),
        // ),
        Positioned(
          bottom: 10,
          child: MapItem(stores: stores),
        )
      ],
    ));
  }
}
