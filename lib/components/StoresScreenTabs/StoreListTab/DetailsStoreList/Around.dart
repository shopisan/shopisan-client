import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/components/Store/store_preview.dart';
import 'package:shopisan/model/Store.dart';

class AroundYou extends StatelessWidget {
  const AroundYou({Key key, @required this.stores}) : super(key: key);

  final List<Store> stores;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(AppLocalizations.of(context).aroundYou.toUpperCase(),
                style: Theme.of(context).textTheme.headline4),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height),
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.vertical,
              children:
                  stores.map((store) => StorePreview(store: store)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
