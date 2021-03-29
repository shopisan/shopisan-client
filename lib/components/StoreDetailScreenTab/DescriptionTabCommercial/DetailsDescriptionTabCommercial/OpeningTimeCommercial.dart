import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/OpeningTime.dart';

class OpeningTimeCommercial extends StatefulWidget {
  const OpeningTimeCommercial({Key key, @required this.openingTime})
      : super(key: key);

  final OpeningTime openingTime;

  @override
  _OpeningTimeCommercialState createState() => _OpeningTimeCommercialState();
}

class _OpeningTimeCommercialState extends State<OpeningTimeCommercial> {
  OpeningTime openingTime;

  @override
  Widget build(BuildContext context) {
    if (openingTime == null) {
      print("openingTime ${widget.openingTime}");
      return Container(
        height: 150,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).scheduleStore,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context).noSchedule,
                    style: TextStyle(color: Colors.black)),
              ],
            )
          ],
        ),
      );
    }

    // return Container(
    //   width: double.infinity,
    //   padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         AppLocalizations.of(context).scheduleStore,
    //         style: GoogleFonts.poppins(
    //           fontSize: 16,
    //           fontWeight: FontWeight.w600,
    //         ),
    //       ),
    //       Row(
    //         children: [
    //           Text("${widget.openingTime.MO}",
    //               style: TextStyle(color: Colors.black)),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
