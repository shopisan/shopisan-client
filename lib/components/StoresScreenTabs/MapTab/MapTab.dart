import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/DetailsMap/GoogleMapScreen.dart';

import 'DetailsMap/MapItem.dart';



class MapTab extends StatefulWidget {
  MapTab({Key key}) : super(key: key);

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
              // todo virer la key de google map;
             child: GoogleMapScreen(),
            ),
            Positioned(
                bottom: 0,
                child:
                  MapItem(),
            )
          ],
        )
    );
  }


}


