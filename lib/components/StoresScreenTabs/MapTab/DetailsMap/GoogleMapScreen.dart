import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/components/Map/CustomeMarker.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/DetailsMap/SearchBar.dart';
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
      @required this.longitude,
      @required this.selectedCountry,
      @required this.setCountry,
      this.loading})
      : super(key: key);

  final List<Store> stores;
  final CategoryCollection categories;
  final double latitude;
  final double longitude;
  final String selectedCountry;
  final void Function(String selectCountry) setCountry;
  final bool loading;

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;
  BitmapDescriptor mapMarker;
  CameraPosition cameraPosition;

  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      cameraPosition = CameraPosition(
          zoom: 14.0, target: LatLng(widget.latitude, widget.longitude));
    }
  }

  Future setCustomMarker() async {
    mapMarker = await CustomMarker.fromAsset("assets/icons/marker.png", 80);
    return mapMarker;
  }

  void setCameraPosition(CameraPosition camPos) {
    setState(() {
      cameraPosition = camPos;
    });
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
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

    setState(() {});
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
            newMarkers.add(
              Marker(
                markerId: MarkerId(
                    address.id.toString() + " " + address.streetAvenue),
                icon: mapMarker,
                position: LatLng(
                  double.parse(address.latitude),
                  double.parse(address.longitude),
                ),
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
                initialCameraPosition: cameraPosition,
              );
            }

            return LoadingIndicator();
          },
          future: _getMarkers(widget.stores),
        ),
        /*SearchBar(
          setCameraPosition: setCameraPosition,
          selectedCountry: widget.selectedCountry,
          setCountry: widget.setCountry,
        )*/
      ],
    );
  }
}
