import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/model/OpeningTime.dart';
import 'package:shopisan/model/Store.dart';

class OpeningTimeCommercial extends StatefulWidget {
  const OpeningTimeCommercial({Key key, @required this.store})
      : super(key: key);

  final Store store;

  @override
  _OpeningTimeCommercialState createState() => _OpeningTimeCommercialState();
}

class _OpeningTimeCommercialState extends State<OpeningTimeCommercial> {
  @override
  Widget build(BuildContext context) {
    Store store = widget.store;
    print("openingTime ${store.openingTimes}");
    return Container(
      // height: 150,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        Text(AppLocalizations.of(context).scheduleStore.toUpperCase(),
            style: Theme.of(context).textTheme.headline3),
        store.appointmentOnly
            ? Text(AppLocalizations.of(context).appointmentOnly,
                style: TextStyle(color: Colors.black))
            : store.openingTimes == null
                ? Text(AppLocalizations.of(context).noSchedule,
                    style: TextStyle(color: Colors.black))
                :
            Column(children:
            store.openingTimes.entries.map((entry){
              print("key= ${entry.key} value: ${entry.value}");
              return Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(child: Text("yup"),width: 75),
                  _getHoursRows(entry.value)
                  ,
                ],),);
            }).toList()
              ,)
      ]),
    );

  }
}

Widget _getHoursRows(hours){
  // @todo faire une condition sur les jours sans horaires ==> afficher fermé
  List<Widget> children = [];
  for (List hour in hours){
    children.add(Text(hour[0] + " à " + hour[1]));
  }

  return Column(children: children,);
}

