import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/utils/common.dart';

const kGoogleApiKey = "AIzaSyDkJlowngFOjqCxtMwPj6APgg2QWlpbEoI";

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchBarState extends State<SearchBar> {
  TextEditingController _cityController = TextEditingController();
  BitmapDescriptor mapMarker;

  _handlePressButton() async {
    print(_cityController.text);
    Map<String, dynamic> location = await searchLocation(_cityController.text);
    print(location['results'][0]['geometry']['location']);

    if (location['results'][0]['geometry']['location']['lat'] != null &&
        location['results'][0]['geometry']['location']['lng'] != null) {
      CameraPosition(
          target: LatLng(
              double.parse(
                  location['results'][0]['geometry']['location']['lat']),
              double.parse(
                  location['results'][0]['geometry']['location']['lng'])),
          zoom: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: EdgeInsets.only(left: 20),
        width: getScreenWidth(context) - 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(controller: _cityController),
            ),
            /*TextInput(
              controller: _cityController,
              label: "label",
              icon: null,
              noIcon: true,
            ),*/
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
