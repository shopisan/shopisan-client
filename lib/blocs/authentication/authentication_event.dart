part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final User user;

  const LoggedIn({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn { user: ${user.username.toString()} }';
}

class LoggedOut extends AuthenticationEvent {}

class UserChangedEvent extends AuthenticationEvent {
  final UserProfile user;

  const UserChangedEvent({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User changed { user: ${user.username.toString()} }';
}

class UserRefreshEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}