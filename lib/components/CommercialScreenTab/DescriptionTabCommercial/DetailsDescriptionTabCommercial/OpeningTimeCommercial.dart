import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Store.dart';

class OpeningTimeCommercial extends StatelessWidget {
  const OpeningTimeCommercial({
    Key key,
    @required this.store,
  }) : super(key: key);

  final Store store;

  @override
  Widget build(BuildContext context) {
    if (null == store) {
      return Center(
          child: Container(
        margin: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      ));
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
