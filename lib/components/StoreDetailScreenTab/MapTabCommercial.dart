import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/utils/common.dart';

class MapTabCommercial extends StatefulWidget {
  const MapTabCommercial({Key key, @required this.store, @required this.height}) : super(key: key);

  final Store store;
  final double height;

  @override
  _MapTabCommercialState createState() => _MapTabCommercialState();
}

class _MapTabCommercialState extends State<MapTabCommercial> {
  GoogleMapController mapController;

  BitmapDescriptor mapMarker;

  _getMarkers() async {
    Set<Marker> _newMarkers = {};
    mapMarker = await setCustomMarker();
    for (Address address in widget.store.addresses) {
      if (address.latitude != null && address.longitude != null) {
        _newMarkers.add(
          Marker(
            markerId: MarkerId(address.id.toString()),
            icon: mapMarker,
            position: LatLng(double.parse(address.latitude),
                double.parse(address.longitude)),
            infoWindow: InfoWindow(
              title: widget.store.name,
            ),
          ),
        );
      }
    }

    return _newMarkers;
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

  @override
  Widget build(BuildContext context) {
    Store store = widget.store;

    final CameraPosition _initialPosition = CameraPosition(
        zoom: 13.0,
        target: LatLng(double.parse(store.addresses[0].latitude),
            double.parse(store.addresses[0].longitude)));

    return Container(
        height: widget.height - 250 - 73,
        // margin: EdgeInsets.only(top: 10),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                onMapCreated: _onMapCreated,
                markers: snapshot.data,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialPosition,
              );
            }

            return LoadingIndicator();
          },
          future: _getMarkers(),
        ));
  }
}
