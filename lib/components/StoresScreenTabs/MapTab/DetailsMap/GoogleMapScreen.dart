import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/model/Store.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key key, @required this.stores}) : super(key: key);

  final List<Store> stores;

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
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

  // // todo son logo est sympa mais il contraste pas des masses avec le fond de google map
  // void _onMapCreated(GoogleMapController controller) {
  //   setState(() {
  //     _markers.add(Marker(
  //         markerId: MarkerId("myMarker"),
  //         position: LatLng(50.6325574, 5.5796662),
  //         icon: mapMarker,
  //         infoWindow: InfoWindow(
  //           title: AppLocalizations.of(context).city,
  //         )));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        // onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition:
            CameraPosition(zoom: 13.0, target: LatLng(50.6325574, 5.5796662)),
      ),
    );
  }
}
