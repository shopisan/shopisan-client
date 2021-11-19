part of 'profile_edit_bloc.dart';

@immutable
abstract class ProfileEditState extends Equatable {
  final UserProfile? user;

  ProfileEditState({this.user});

  @override
  List<Object> get props => [];
}

class InitialProfileEditState extends ProfileEditState {
  @override
  List<Object> get props => [];
}

class StartedProfileEditState extends ProfileEditState {
  final UserProfile user;

  StartedProfileEditState({required this.user});

  @override
  List<Object> get props => [user];
}

class LoadingProfileEditState extends ProfileEditState {
  final UserProfile user;

  LoadingProfileEditState({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorProfileEditState extends ProfileEditState {
  final String error;
  final UserProfile user;

  ErrorProfileEditState({required this.error, required this.user});

  @override
  List<Object> get props => [error, user];
}

class SuccessProfileEditState extends ProfileEditState {
  final UserProfile user;

  SuccessProfileEditState({required this.user});

  @override
  List<Object> get props => [user];
}
