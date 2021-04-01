import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/model/Store.dart';

import 'opening_hours_form.dart';

class OpeningHoursTab extends StatefulWidget {
  OpeningHoursTab({@required this.store});
  final Store store;

  @override
  _OpeningHoursTabState createState() => _OpeningHoursTabState();
}

class _OpeningHoursTabState extends State<OpeningHoursTab> {
  Store store;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 10, 10),
              child: Text(
                AppLocalizations.of(context).scheduleStore.toUpperCase(),
                style: Theme.of(context).textTheme.headline3,
              ),
            )
          ],
        ),
        CheckboxListTile(
            value: store.appointmentOnly,
            title: Text(AppLocalizations.of(context).appointmentOnly),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              store.appointmentOnly = value;
              BlocProvider.of<EditStoreBloc>(context)
                  .add(StoreEditEvent(store: store));
            }),
        store.appointmentOnly
            ? Column()
            : OpeningHoursForm(
                store: store,
              ),
      ],
    ));
  }
}
