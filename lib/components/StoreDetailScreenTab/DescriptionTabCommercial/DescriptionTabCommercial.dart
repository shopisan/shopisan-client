import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DescriptionTabCommercial/DetailsDescriptionTabCommercial/ConnectCommercial.dart';
import 'package:shopisan/model/OpeningTime.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

import 'DetailsDescriptionTabCommercial/OpeningTimeCommercial.dart';

class DescriptionTabCommercial extends StatefulWidget {
  const DescriptionTabCommercial({
    Key key,
    @required this.store,
  }) : super(key: key);

  final Store store;

  @override
  _DescriptionTabCommercialState createState() =>
      _DescriptionTabCommercialState();
}

class _DescriptionTabCommercialState extends State<DescriptionTabCommercial> {

  @override
  Widget build(BuildContext context) {
    Store store = widget.store;

    return Container(
        margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: CustomColors.spread),
                )),
                child: Text(
                    AppLocalizations.of(context).description.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SingleChildScrollView(
                  child: Text(
                    store?.description ?? "",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              OpeningTimeCommercial(
                store: store,
              ),
              ConnectCommercial(
                store: store,
              ),
            ],
          ),
        ));
  }
}
