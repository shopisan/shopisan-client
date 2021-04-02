part of 'registration_bloc.dart';

@immutable
abstract class RegistrationState extends Equatable {
  final Map<String, String> data;

  RegistrationState({@required this.data});

  @override
  List<Object> get props => [data];
}

class InitialRegistrationState extends RegistrationState {
  final Map<String, String> data;
  final bool showSnack;

  InitialRegistrationState({@required this.data, this.showSnack = false});

  @override
  List<Object> get props => [data];
}

class LoadingRegistrationState extends RegistrationState {
  final Map<String, String> data;

  LoadingRegistrationState({@required this.data});

  @override
  List<Object> get props => [data];
}

class DoneRegistrationState extends RegistrationState {
  final Map<String, String> data;
  final bool success;
  final Map<String ,dynamic> message;

  DoneRegistrationState(
      {@required this.data, @required this.success, this.message});

  @override
  List<Object> get props => [data, success, message];
}
