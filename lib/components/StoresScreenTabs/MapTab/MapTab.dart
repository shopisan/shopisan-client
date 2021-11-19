import 'package:flutter/material.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/DetailsMap/GoogleMapScreen.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

import 'DetailsMap/MapItem.dart';

class MapTab extends StatefulWidget {
  const MapTab(
      {
      required this.stores,
      required this.latitude,
      required this.longitude,
      required this.selectedCountry,
      required this.setCountry,
      this.loading = false})
      : super();

  final List<Store> stores;
  final double latitude;
  final double longitude;
  final String selectedCountry;
  final void Function(String selectCountry) setCountry;
  final bool loading;

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  CategoryCollection categories = CategoryCollection(categories: []);
  AddressCollection addresses = AddressCollection(addresses: []);

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
        body: */
        Stack(
      children: [
        Positioned.fill(
          child: GoogleMapScreen(
              stores: widget.stores,
              categories: categories,
              latitude: widget.latitude,
              longitude: widget.longitude,
              selectedCountry: widget.selectedCountry,
              setCountry: widget.setCountry,
              loading: widget.loading),
        ),
        Positioned(
          bottom: 0,
          child: MapItem(stores: widget.stores, categories: categories),
        )
      ],
    ) /*)*/;
  }
}
