part of 'registration_bloc.dart';

@immutable
abstract class RegistrationState extends Equatable {
  final Map<String, String> data;

  RegistrationState({required this.data});

  @override
  List<Object> get props => [data];
}

class InitialRegistrationState extends RegistrationState {
  final Map<String, String> data;
  final bool showSnack;

  InitialRegistrationState({required this.data, this.showSnack = false}) :
        super(data: data);

  @override
  List<Object> get props => [data];
}

class LoadingRegistrationState extends RegistrationState {
  final Map<String, String> data;

  LoadingRegistrationState({required this.data}) : super(data: data);

  @override
  List<Object> get props => [data];
}

class DoneRegistrationState extends RegistrationState {
  final Map<String, String> data;
  final bool success;
  final List<String> message;

  DoneRegistrationState(
      {required this.data, required this.success, required this.message}) :
        super(data: data);

  @override
  List<Object> get props => [data, success, message];
}
