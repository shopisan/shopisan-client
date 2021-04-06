import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Store.dart';

class OpeningTimeCommercial extends StatefulWidget {
  const OpeningTimeCommercial({Key key, @required this.store})
      : super(key: key);

  final Store store;

  @override
  _OpeningTimeCommercialState createState() => _OpeningTimeCommercialState();
}

class _OpeningTimeCommercialState extends State<OpeningTimeCommercial> {
  _getDayText(day){
    switch(day){
      case 'MO':
        return AppLocalizations.of(context).mo;
      case 'TU':
        return AppLocalizations.of(context).tu;
      case 'WE':
        return AppLocalizations.of(context).we;
      case 'TH':
        return AppLocalizations.of(context).th;
      case 'FR':
        return AppLocalizations.of(context).fr;
      case 'SA':
        return AppLocalizations.of(context).sa;
      case 'SU':
        return AppLocalizations.of(context).su;
    }
  }

  @override
  Widget build(BuildContext context) {
    Store store = widget.store;
    return Container(
      // height: 150,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).scheduleStore.toUpperCase(),
                style: Theme.of(context).textTheme.headline3),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: store.appointmentOnly
                  ? Text(AppLocalizations.of(context).appointmentOnly,
                      style: Theme.of(context).textTheme.bodyText1)
                  : store.openingTimes == null
                      ? Text(AppLocalizations.of(context).noSchedule,
                          style: Theme.of(context).textTheme.bodyText1)
                      : Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: store.openingTimes.entries.map((entry) {
                            return Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                            child: Row(
                              children: [
                                SizedBox(
                                    child: Text(
                                      _getDayText(entry.key),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                      width: 90),
                                  _getHoursRows(entry.value),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
            )
          ]),
    );
  }
}

Widget _getHoursRows(hours) {
  // @todo faire une condition sur les jours sans horaires ==> afficher fermé
  List<Widget> children = [];
  for (List hour in hours) {
    children.add(
      Text(
        hour[0] + " à " + hour[1],
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
      ),
    );
  }

  return Column(
    children: children,
  );
}
