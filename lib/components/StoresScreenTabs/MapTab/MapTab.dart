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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: GoogleMapScreen(),
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
            child: Expanded(
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
        ),
        Positioned(
          bottom: 100,
          right: 10,
          // ignore: deprecated_member_use
          child: FlatButton(
            color: CustomColors.iconsActive,
            height: 40,
            minWidth: 20,
            onPressed: () {
              // @todo plutot replacer la map sur sa position actuelle
            },
            child: Icon(Icons.location_searching_outlined),
          ),
        ),
        // Positioned(
        //   top: 200,
        //   left: 20,
        //   child: Text("$latitudeData"),
        // ),
        // Positioned(
        //   top: 220,
        //   left: 20,
        //   child: Text("$longitudeData"),
        // ),
        Positioned(
          bottom: 0,
          child: MapItem(),
        )
      ],
    ));
  }
}
