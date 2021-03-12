import 'package:flutter/material.dart';
// import 'package:shopisan/components/StoreList/List.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(child: Text(AppLocalizations.of(context).helloWorld),),
        // child: StoreList()//,
    );
  }
}

