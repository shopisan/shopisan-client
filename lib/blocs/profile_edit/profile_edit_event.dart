part of 'profile_edit_bloc.dart';

@immutable
abstract class ProfileEditEvent {
  const ProfileEditEvent();
}

class InitEvent extends ProfileEditEvent {}

class SubmitEvent extends ProfileEditEvent {
  final UserProfile user;

  const SubmitEvent({
    required this.user
  });

  List<Object> get props => [user];

  @override
  String toString() => 'Submit user { user: $user }';
}

class ChangeEvent extends ProfileEditEvent {
  final UserProfile user;

  const ChangeEvent({
    required this.user
  });

  List<Object> get props => [user];

  @override
  String toString() => 'Submit user { user: $user }';
}

class ChangePictureEvent extends ProfileEditEvent {
  final File picture;

  const ChangePictureEvent({
    required this.picture
  });

  List<Object> get props => [picture];

  @override
  String toString() => 'Change user { photo: $picture }';
}
