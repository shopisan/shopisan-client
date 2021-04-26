import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:meta/meta.dart';
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

    } else if (event is SubmitRegistrationEvent) {
      Map<String, String> data = event.data;
      yield LoadingRegistrationState(data: data);
      bool valid = true;

      if (valid) {
        try {
          bool rslt = await registrationUserProfile(data);
          if (rslt) {
            FirebaseAnalytics().logEvent(name: 'Registration',parameters:null);
            yield DoneRegistrationState(data: data, success: true);
          } else {
            yield DoneRegistrationState(data: data, success: false);
          }
        } catch (exception) {
          Map<String, dynamic> error = jsonDecode(exception.message);
          List<String> message = [];

          if (error.containsKey("email")) {
            message.add("email_taken");
          }

          if (error.containsKey("username")){
            message.add("userName_taken");
          }
          
          yield DoneRegistrationState(
              data: data, success: false, message: message); // todo reste a faire une condition sur le contenu de l'exception
        }
      }
    }
  }
}
