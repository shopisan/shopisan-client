import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/utils/common.dart';

const kGoogleApiKey = "AIzaSyDkJlowngFOjqCxtMwPj6APgg2QWlpbEoI";

class SearchBar extends StatefulWidget {
  final ValueChanged<CameraPosition> setCameraPosition;
  final List selectedCountries;
  final void Function(List selectCountries) setCountries;

  SearchBar({
    @required this.setCameraPosition,
    @required this.selectedCountries,
    @required this.setCountries});

  @override
  _SearchBarState createState() => _SearchBarState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchBarState extends State<SearchBar> {
  TextEditingController _cityController = TextEditingController();
  BitmapDescriptor mapMarker;

  _handlePressButton() async {
    Map<String, dynamic> location = await searchLocation(_cityController.text);
    String country = location['results'][0]['address_components'][3]['short_name'];

    if (location['results'][0]['geometry']['location']['lat'] != null &&
        location['results'][0]['geometry']['location']['lng'] != null) {
      if (!widget.selectedCountries.contains(country)) {
        List<dynamic> countries = widget.selectedCountries;
        countries.add(country);
        widget.setCountries(countries);
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
    return Positioned(
      top: 10,
      left: 10,
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
