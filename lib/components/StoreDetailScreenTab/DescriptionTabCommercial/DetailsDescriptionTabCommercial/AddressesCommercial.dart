import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Store.dart';

class AddressesCommercial extends StatefulWidget {
  const AddressesCommercial({Key key, @required this.store}) : super(key: key);

  final Store store;
  @override
  _AddressesCommercialState createState() => _AddressesCommercialState();
}

class _AddressesCommercialState extends State<AddressesCommercial> {
  String _addressesToString(List<Address> address) {
    String str = "";
    int index = 0;
    for (Address add in address) {
      if (index > 0) {
        str += " \n ";
      } else {
        Text(
          "Pad d'addresse",
          style: Theme.of(context).textTheme.bodyText1,
        );
      }
      str += add.streetAvenue +
          ", " +
          add.postalCode +
          " - " +
          add.city +
          " " +
          add.country;

      index++;
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).addresses.toUpperCase(),
              style: Theme.of(context).textTheme.headline3),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              _addressesToString(widget.store.addresses),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
