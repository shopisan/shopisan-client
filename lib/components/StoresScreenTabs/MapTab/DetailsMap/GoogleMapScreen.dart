import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

  @override
  void initState() {
    super.initState();
    setCustomMarkers();
  }

  void setCustomMarkers() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/icons/logo_square.svg");
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('id-1'),
          icon: mapMarker,
          infoWindow: InfoWindow(
            title: AppLocalizations.of(context).commercialName,
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        markers: _markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition:
            CameraPosition(zoom: 13.0, target: LatLng(50.6325574, 5.5796662)),
      ),
    );
  }
}
