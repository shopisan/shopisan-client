import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/utils/common.dart';

const kGoogleApiKey = "AIzaSyDkJlowngFOjqCxtMwPj6APgg2QWlpbEoI";

class SearchBar extends StatefulWidget {
  final ValueChanged<CameraPosition> setCameraPosition;
  final String selectedCountry;
  final void Function(String selectCountry) setCountry;

  SearchBar({
    required this.setCameraPosition,
    required this.selectedCountry,
    required this.setCountry});

  @override
  _SearchBarState createState() => _SearchBarState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchBarState extends State<SearchBar> {
  TextEditingController _cityController = TextEditingController();
  late BitmapDescriptor mapMarker;

  _getCountry(addrComponents) {
    for (var i = 0; i < addrComponents.length; i++) {
      if (addrComponents[i]["types"][0] == "country") {
        return addrComponents[i]["short_name"];
      }
      if (addrComponents[i]["types"].length == 2) {
        if (addrComponents[i]["types"][0] == "political") {
          return addrComponents[i]["short_name"];
        }
      }
    }
    return "";
  }

  _handlePressButton() async {
    Map<String, dynamic> location = await searchLocation(_cityController.text);
    String country = _getCountry(location['results'][0]['address_components']);

    if (location['results'][0]['geometry']['location']['lat'] != null &&
        location['results'][0]['geometry']['location']['lng'] != null) {
      if (!widget.selectedCountry.contains(country) && country != "") {
        String country = widget.selectedCountry;
        widget.setCountry(country);
      }

      widget.setCameraPosition(
          CameraPosition(
              target: LatLng(
                  location['results'][0]['geometry']['location']['lat'],
                  location['results'][0]['geometry']['location']['lng']),
              zoom: 10)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // todo changer la position du row si platfrorm == IOS
    return Positioned(
      top: 10,
      left: 10,
      // right: Platform.isIOS ? 10 : null,
      child: Container(
        height: 42,
        padding: EdgeInsets.only(left: 20),
        width: getScreenWidth(context) - 75,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(controller: _cityController),
            ),
            IconButton(
              onPressed: _handlePressButton,
              icon: Icon(Icons.search),
            )
          ],
        ),
      ),
    );
  }
}
