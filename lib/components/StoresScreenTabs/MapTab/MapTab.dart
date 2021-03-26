import 'package:flutter/material.dart';
import 'package:shopisan/components/StoresScreenTabs/MapTab/DetailsMap/GoogleMapScreen.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

import 'DetailsMap/MapItem.dart';

class MapTab extends StatefulWidget {
  const MapTab({Key key, @required this.stores}) : super(key: key);

  final List<Store> stores;

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  CategoryCollection categories = CategoryCollection(categories: []);
  AddressCollection addresses = AddressCollection(addresses: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: GoogleMapScreen(stores: widget.stores, categories: categories),
        ),
        Positioned(
          top: 10,
          right: 15,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Search..."),
              ),
          ),
        ),
        Positioned(
          bottom: 10,
          child: MapItem(stores: widget.stores, categories: categories),
        )
      ],
    ));
  }
}
