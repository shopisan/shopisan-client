import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/utils/common.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen(
      {Key key,
      @required this.stores,
      @required this.categories,
      @required this.latitude,
      @required this.longitude})
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
        ImageConfiguration(), "assets/icons/marker.png");
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

  // void searchAndNavigate() async {
  //   LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => PlacePicker(
  //             "AIzaSyCegSUW6N1wYgRONnn_4kOZXUzFu7w2Drs",
  //             // displayLocation: customLocation,
  //           )));
  //   print(result);
  // }

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
            newMarkers.add(
              Marker(
                markerId: MarkerId(
                    address.id.toString() + " " + address.streetAvenue),
                icon: mapMarker,
                position: LatLng(double.parse(address.latitude),
                    double.parse(address.longitude)),
                infoWindow: InfoWindow(
                  title: store.name,
                  onTap: () {
                    Navigator.pushNamed(context, "/store_detail",
                        arguments: {"storeId": store.id});
                  },
                ),
              ),
            );
          }
        }
      }

      return newMarkers;
    }

    return Stack(
      children: [
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                padding: EdgeInsets.only(left: 5, bottom: 80),
                onMapCreated: _onMapCreated,
                markers: snapshot.data,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                tiltGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                    zoom: 14.0,
                    target: LatLng(widget.latitude, widget.longitude)),
              );
            }

            return LoadingIndicator();
          },
          future: _getMarkers(widget.stores),
        ),
        Positioned(
          top: 10,
          left: 10,
          // child: AddressSearch(),
          child: Container(
            height: 42,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: OutlinedButton(
              // onPressed: searchAndNavigate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).search,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
