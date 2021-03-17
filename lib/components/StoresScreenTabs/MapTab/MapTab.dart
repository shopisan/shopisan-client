import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/DetailsMap/GoogleMapScreen.dart';
import 'package:shopisan/theme/colors.dart';

import 'DetailsMap/MapItem.dart';

class MapTab extends StatefulWidget {
  MapTab({Key key}) : super(key: key);

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  String latitudeData = "";
  String longitudeData = "";

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudeData = "${geoposition.latitude}";
      longitudeData = "${geoposition.longitude}";
    });
  }

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
          top: 200,
          left: 20,
          child: Text(latitudeData),
        ),
        Positioned(
          top: 220,
          left: 20,
          child: Text(longitudeData),
        ),
        Positioned(
          right: 20,
          top: 20,
          // ignore: deprecated_member_use
          child: FlatButton(
            color: CustomColors.iconsActive,
            height: 50,
            minWidth: 20,
            onPressed: () {
              getCurrentLocation();
            },
            child: Icon(Icons.location_searching_outlined),
          ),
        ),
        Positioned(
          bottom: 0,
          child: MapItem(),
        )
      ],
    ));
  }
}
