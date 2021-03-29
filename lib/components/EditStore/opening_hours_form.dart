import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OpeningHoursForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CheckboxListTile(
              value: false,
              title: Text(AppLocalizations.of(context).appointmentOnly),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                print(value);
                // @todo selon true/false changer le json (faire passer ca en boolean histoire de pas supprimer les horaires si on change
              })
        ],
      ),
    );
  }
}
