import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/models/OpeningTime.dart';
import 'package:shopisan/models/Store.dart';

class TimesCommercial extends StatefulWidget {
  const TimesCommercial(
      {Key key, @required this.storeId, Store store, this.openingTimes})
      : super(key: key);

  final int storeId;
  final OpeningTimeCollection openingTimes;

  @override
  _TimesCommercialState createState() => _TimesCommercialState();
}

class _TimesCommercialState extends State<TimesCommercial> {
  Store store;

  @override
  Widget build(BuildContext context) {
    if (null == widget.storeId) {
      return CircularProgressIndicator();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // AppLocalizations.of(context).scheduleStore,
            AppLocalizations.of(context).scheduleStore,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text("${store.openingTimes}",
                  style: TextStyle(color: Colors.black)),
            ],
          )
        ],
      ),
    );
  }
}
