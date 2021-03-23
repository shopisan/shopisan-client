import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/authentication/authentication_bloc.dart';
import 'package:shopisan/repository/user_repository.dart';
import 'package:shopisan/theme/style.dart';
import 'package:shopisan/utils/router_generator.dart';

void main() {
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
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
