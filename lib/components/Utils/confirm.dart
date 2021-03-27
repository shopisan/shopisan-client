import 'package:flutter/material.dart';

class Confirm extends StatelessWidget {
  final Function executeFct;
  final String title;
  final String text;

  Confirm({@required this.executeFct, this.text, this.title});

  @override
  Widget build(BuildContext context) {
    final Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        // @todo faire executer la fonction que l'on fera passer en param
        executeFct();
        Navigator.of(context).pop();
      },
    );

    final Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
        // @ todo fermer le dialog
      },
    );


    return  AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        okButton,
        cancelButton
      ],
    );
  }
}
