import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen(
      {Key key, @required this.stores, @required this.categories})
      : super(key: key);

  final List<Store> stores;
  final CategoryCollection categories;

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;

  Set<Marker> _markers = {};
  // BitmapDescriptor mapMarker;
  String searchAddress;

  @override
  void initState() {
    super.initState();
    // setCustomMarker();
  }

  // void setCustomMarker() async {
  //   mapMarker = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(), "assets/icons/pin.png");
  // }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      String style1 = jsonEncode([
        [
          {
            "stylers": [
              {"visibility": "simplified"}
            ]
          },
          {
            "featureType": "landscape.man_made",
            "stylers": [
              {"visibility": "on"}
            ]
          },
          {
            "featureType": "poi.business",
            "stylers": [
              {"visibility": "off"}
            ]
          },
          {
            "featureType": "poi.park",
            "stylers": [
              {"visibility": "on"}
            ]
          }
        ]
      ]);

      mapController.setMapStyle(style1);
      // _markers.add(Marker(
      //     markerId: MarkerId("myMarker"),
      //     icon: mapMarker,
      //     position: LatLng(50.6325574, 5.5796662),
      //     infoWindow: InfoWindow(
      //       title: searchAddress,
      //     )));
    });
  }

  void searchAndNavigate() {
    // Geolocator.placemarkFromAddress(searchAddress).then((result) {
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target:
    //           LatLng(result[0].position.latitude, result[0].position.longitude),
    //       zoom: 14)));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          // markers: _markers,
          myLocationEnabled: true,
          zoomControlsEnabled: false,

          initialCameraPosition:
              CameraPosition(zoom: 14.0, target: LatLng(50.6325574, 5.5796662)),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            height: 42,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.search),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).search,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10, top: 10),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search_outlined),
                    onPressed: searchAndNavigate,
                    iconSize: 18,
                  )),
              onChanged: (val) {
                setState(() {
                  searchAddress = val;
                });
              },
            ),
          ),
        )
      ],
    ));
  }
}
