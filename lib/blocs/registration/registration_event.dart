part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent extends Equatable {}

class ChangedRegistrationEvent extends RegistrationEvent {
  final Map<String, String> data;

  ChangedRegistrationEvent({@required this.data});

  @override
  List<Object> get props => [data];
}

class SubmitRegistrationEvent extends RegistrationEvent {
  final Map<String, String> data;

  SubmitRegistrationEvent({@required this.data});

  @override
  List<Object> get props => [data];
}

class SnackShownRegistrationEvent extends RegistrationEvent {
  @override
  List<Object> get props => [];
}
