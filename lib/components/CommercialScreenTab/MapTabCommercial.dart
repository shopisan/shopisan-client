import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/model/Address.dart';

class MapTabCommercial extends StatefulWidget {
  const MapTabCommercial({Key key, this.addresses}) : super(key: key);

  final AddressCollection addresses;

  @override
  _MapTabCommercialState createState() => _MapTabCommercialState();
}

class _MapTabCommercialState extends State<MapTabCommercial> {
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

  // todo son logo est sympa mais il contraste pas des masses avec le fond de google map
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("myMarker"),
          // position: LatLng(50.6325574, 5.5796662),

          icon: mapMarker,
          infoWindow: InfoWindow(
            title: AppLocalizations.of(context).city,
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition:
            CameraPosition(zoom: 13.0, target: LatLng(50.6325574, 5.5796662)),
      ),
    );
  }
}
