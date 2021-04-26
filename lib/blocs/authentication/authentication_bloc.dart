import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:meta/meta.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/model/user_model.dart';
import 'package:shopisan/repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(UserRepository != null),
        super(null);

  AuthenticationState get initialState => AuthenticationUnintialized();

  Future<AuthenticationState> _getUser() async {
    try {
      UserProfile user = await getUserProfile();
      return AuthenticationAuthenticated(user: user);
    } catch (exception) {
      bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        userRepository.deleteToken(id: 0);
      }

      return AuthenticationUnauthenticated();
    }

    return AuthenticationUnauthenticated();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield await _getUser();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();

      await userRepository.deleteToken(id: 0);
      await userRepository.persistToken(user: event.user);
      FirebaseAnalytics().logEvent(name: 'Login',parameters:null);
      yield await _getUser();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();

      await userRepository.deleteToken(id: 0);

      FirebaseAnalytics().logEvent(name: 'Logout',parameters:null);
      yield AuthenticationUnauthenticated();
    } else if (event is UserChangedEvent) {
      if (event.user != null) {
        yield AuthenticationAuthenticated(user: event.user);
      }
    } else if (event is UserRefreshEvent) {
      UserProfile user = await getUserProfile();
      print("refresh user: ${user.profile.ownedStores}");
      if (user != null) {
        yield AuthenticationAuthenticated(user: user);
      }
    }
  }
}
