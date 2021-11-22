import 'dart:async';
import 'dart:io';

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/repository/user_repository.dart';
import 'package:shopisan/theme/style.dart';
import 'package:shopisan/utils/router_generator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // if (kDebugMode) {
    //   await FirebaseCrashlytics.instance
    //       .setCrashlyticsCollectionEnabled(false);
    // }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    final userRepository = UserRepository();

    // FirebaseCrashlytics.instance.crash();

    sleep(Duration(seconds: 1));

    runApp(BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    ));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class App extends StatelessWidget {
  static final facebookAppEvents = FacebookAppEvents();
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  final UserRepository userRepository;

  App({required this.userRepository}) : super();

  @override
  Widget build(BuildContext context) {
    _analytics.logAppOpen();
    // facebookAppEvents.logEvent(name: "App open");

    return MaterialApp(
        title: 'Shopisan',
        theme: CustomTheme.lightTheme,
        // @todo garder ca au cas ou on en a besoin autre part
        // home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        //   builder: (context, state) {
        //     if (state is AuthenticationUnintialized) {
        //       return SplashPage();
        //     }
        //     if (state is AuthenticationAuthenticated) {
        //       return HomePage();
        //     }
        //     if (state is AuthenticationUnauthenticated) {
        //       return LoginPage(userRepository: userRepository,);
        //     }
        //     if (state is AuthenticationLoading) {
        //       return LoadingIndicator();
        //     }
        //   },
        // ),
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: _analytics),
        ],
        initialRoute: '/',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

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
