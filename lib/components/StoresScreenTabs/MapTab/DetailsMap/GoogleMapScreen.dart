import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/model/Address.dart';
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
  BitmapDescriptor mapMarker;
  String searchAddress;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/icons/pin.png");
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    String style2 = jsonEncode([
      {
        "featureType": "poi.business",
        "stylers": [
          {"visibility": "off"}
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text",
        "stylers": [
          {"visibility": "off"}
        ]
      }
    ]);

    mapController.setMapStyle(style2);

    // _markers.add(Marker(
    //     markerId: MarkerId("myMarker"),
    //     icon: mapMarker,
    //     position: LatLng(50.6325574, 5.5796662),
    //     infoWindow: InfoWindow(
    //       title: searchAddress,
    //     )));

    getMarkers(widget.stores);
  }

  void searchAndNavigate() {
    // Geolocator.placemarkFromAddress(searchAddress).then((result) {
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target:
    //           LatLng(result[0].position.latitude, result[0].position.longitude),
    //       zoom: 14)));
    // });
  }

  Set<Marker> getMarkers(List<Store> stores) {
    for (Store store in stores) {
      for (Address address in store.addresses) {
        if (address.latitude != null && address.longitude != null) {
          _markers.add(Marker(
              markerId: MarkerId(address.id.toString()),
              icon: mapMarker,
              position: LatLng(double.parse(address.latitude),
                  double.parse(address.longitude)),
              infoWindow: InfoWindow(
                title: store.name,
              )));
        }
      }
    }

    setState(() {
      _markers = _markers;
    });

    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    print("markers: $_markers");

    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition:
              CameraPosition(zoom: 14.0, target: LatLng(45.75, 4.85)),
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
