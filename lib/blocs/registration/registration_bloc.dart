import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/api_connection/api_connection.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc()
      : super(InitialRegistrationState(data: {
          "email": "",
          "username": "",
          "password": "",
          "passwordRepeat": ""
        }));

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is ChangedRegistrationEvent) {
      Map<String, String> data = event.data;

      yield InitialRegistrationState(data: data);
    } else if (event is SubmitRegistrationEvent){
      Map<String, String> data = event.data;
      print(data);
      yield LoadingRegistrationState(data: data);
      if (data["password"] != data['repeatPassword']) {
        yield DoneRegistrationState(data: data, success: true, message: {
          "password": [], // todo mettre des key en param, et traduire depuis le widget avec un switch
          "repeatPassword": []
        });
      }
      // @todo valider le form (tester l'envoi d'une addresse mail mal formée)
      // @todo envoyer vers le controller
      try {
        registrationUserProfile(data);
        yield DoneRegistrationState(data: data, success: true);
      } catch (exception){
        print("exception: $exception");
        yield DoneRegistrationState(data: data, success: false);
      }

    }
  }
}
