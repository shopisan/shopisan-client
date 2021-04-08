import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/theme/colors.dart';

class SaveButton extends StatelessWidget {
  final Function callback;

  SaveButton({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: CustomColors.textDark,
      ),
      child: TextButton(
        onPressed: () {
          callback();
        },
        child: Text(
          AppLocalizations.of(context).save,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
