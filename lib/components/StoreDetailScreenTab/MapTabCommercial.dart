import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class MapTabCommercial extends StatefulWidget {
  const MapTabCommercial({Key key, @required this.store, @required this.height})
      : super(key: key);

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

    final bool isNull = store.addresses.length == 0 ||
        (store.addresses[0]?.latitude == null ||
            store.addresses[0]?.longitude == null);

    final CameraPosition _initialPosition = isNull
        ? null
        : CameraPosition(
            zoom: 13.0,
            target: LatLng(double.parse(store.addresses[0].latitude),
                double.parse(store.addresses[0].longitude)));

    return Container(
        height: widget.height - 250 - 73,
        child: null != _initialPosition
            ? FutureBuilder(
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
              )
            : Center(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).noLocationForThisStore,
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.all(20)),
                          FaIcon(
                            FontAwesomeIcons.locationArrow,
                            color: CustomColors.iconsActive,
                            size: 40,
                          )
                        ],
                      ),
                    )

                    /*Text(
                        AppLocalizations.of(context).noLocationForThisStore,
                        style: GoogleFonts.poppins(
                            color: CustomColors.textDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 16))*/
    )));
  }
}
