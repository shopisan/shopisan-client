import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/theme/colors.dart';

class SaveButton extends StatelessWidget {
  final Function callback;

  SaveButton({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: CustomColors.iconsActive,
      ),
      child: TextButton(
        onPressed: () {
          callback();
        },
        child: Text(AppLocalizations.of(context).save,
            style: Theme.of(context).textTheme.headline3),
      ),
    );
  }
}
