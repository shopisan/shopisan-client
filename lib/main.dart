import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/theme/style.dart';
import 'package:shopisan/utils/router_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shopisan',
        theme: CustomTheme.lightTheme,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales
        // localizationsDelegates: [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: [
        //   const Locale('fr', '')
        // ]
        );
  }
}
