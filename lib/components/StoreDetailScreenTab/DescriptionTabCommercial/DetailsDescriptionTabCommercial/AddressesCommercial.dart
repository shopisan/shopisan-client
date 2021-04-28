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
      if (null != add.streetAvenue && null != add.postalCode) {
        if (index > 0) {
          str += "\n\n";
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
    }

    if (index == 0) {
      return AppLocalizations.of(context).noAddresses;
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
          Text(
            widget.store.addresses.length == 1
                ? AppLocalizations.of(context).address.toUpperCase()
                : AppLocalizations.of(context).addresses.toUpperCase(),
            style: Theme.of(context).textTheme.headline3,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              widget.store.addresses.length > 0
                  ? _addressesToString(widget.store.addresses)
                  : AppLocalizations.of(context).noAddresses,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
