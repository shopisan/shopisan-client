import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Store.dart';

class MapTabCommercial extends StatefulWidget {
  const MapTabCommercial({Key key, @required this.store}) : super(key: key);

  final Store store;

  @override
  _MapTabCommercialState createState() => _MapTabCommercialState();
}

class _MapTabCommercialState extends State<MapTabCommercial> {
  GoogleMapController mapController;

  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

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
    for (Address address in widget.store.addresses) {
      if (address.latitude != null && address.longitude != null) {
        _markers.add(
          Marker(
            markerId: MarkerId("myMarker"),
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

    setState(() {
      _markers = _markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    Store store = widget.store;
    print("store $store");

    final CameraPosition _initialPosition = CameraPosition(
        zoom: 13.0,
        target: LatLng(double.parse(store.addresses[0].latitude),
            double.parse(store.addresses[0].longitude)));

    return Container(
      height: 340,
      margin: EdgeInsets.only(top: 30),
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialPosition,
      ),
    );
  }
}
