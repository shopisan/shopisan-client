import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/model/UserProfile.dart';

import 'package:shopisan/repository/user_repository.dart';
import 'package:shopisan/model/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(UserRepository != null), super(null);

  AuthenticationState get initialState => AuthenticationUnintialized();

  Future<AuthenticationState> _getUser() async {
    try{
      UserProfile user = await getUserProfile();
      return AuthenticationAuthenticated(user: user);
    } catch(exception){
      // yield AuthenticationUnauthenticated();
      print("Issue during user fetch");
    }

    return AuthenticationUnauthenticated();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,) async* {
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

      await userRepository.persistToken(
          user: event.user
      );
      yield await _getUser();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();

      await userRepository.deleteToken(id: 0);

      yield AuthenticationUnauthenticated();
    } else if (event is UserChangedEvent) {
      if (event.user != null) {
        yield AuthenticationAuthenticated(user: event.user);
      }
    }
  }
}