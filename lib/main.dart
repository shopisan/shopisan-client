import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/repository/user_repository.dart';
import 'package:shopisan/theme/style.dart';
import 'package:shopisan/utils/router_generator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final userRepository = UserRepository();
  
  sleep(Duration(seconds: 1));

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
