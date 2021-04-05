import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen(
      {Key key, @required this.stores, @required this.categories, @required this.latitude, @required this.longitude})
      : super(key: key);

  final List<Store> stores;
  final CategoryCollection categories;
  final double latitude;
  final double longitude;

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;
  BitmapDescriptor mapMarker;
  String searchAddress;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  Future setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/icons/pin.png");
    return mapMarker;
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

    Future<Set<Marker>> _getMarkers(List<Store> stores) async {
      if (null == mapMarker) {
        mapMarker = await setCustomMarker();
      }

      Set<Marker> newMarkers = {};
      for (Store store in stores) {
        for (Address address in store.addresses) {
          if (address.latitude != null && address.longitude != null) {
            newMarkers.add(Marker(
                markerId: MarkerId(address.id.toString() + " " + address.streetAvenue),
                icon: mapMarker,
                position: LatLng(double.parse(address.latitude),
                    double.parse(address.longitude)),
                infoWindow: InfoWindow(
                  title: store.name,
                )));
          }
        }
      }

      return newMarkers;
    }


    return Stack(
      children: [
        FutureBuilder(builder: (context, snapshot){
          if (snapshot.hasData) {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              markers: snapshot.data,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition:
              CameraPosition(zoom: 14.0, target: LatLng(widget.latitude, widget.longitude)),
            );
          }

          return LoadingIndicator();
        }, future: _getMarkers(widget.stores),),
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
      ],);
  }
}
