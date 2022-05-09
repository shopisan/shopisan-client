import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/model/File.dart' as FileModel;
import 'package:shopisan/model/UserProfile.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(InitialProfileEditState());

  @override
  Stream<ProfileEditState> mapEventToState(ProfileEditEvent event) async* {
    if (event is InitEvent) {
      yield InitialProfileEditState();
      UserProfile user = await getUserProfile();
      yield StartedProfileEditState(user: user);
    } else if (event is ChangeEvent){
      yield StartedProfileEditState(user: event.user);
    } else if (event is ChangePictureEvent){
      UserProfile user = state.user!;
      yield LoadingProfileEditState(user: user);
      // @todo uploader l'image ++ recupérer le fichier créé ++ associer a l'obj
      try {
        FileModel.File? resp = await uploadFile(event.picture, "profile_pic");

        if (null != resp){
          user.profile!.picture = resp;
          yield StartedProfileEditState(user: user);
        } else {
          yield ErrorProfileEditState(error: 'picture', user: user);
        }
      } catch (exception){
        yield ErrorProfileEditState(error: 'picture', user: user);
      }

    } else if (event is SubmitEvent){
      UserProfile user = state.user!;
      yield LoadingProfileEditState(user: user);

      try {
        await editUserProfile(user);
        yield SuccessProfileEditState(user: user);
      } catch (exception){
        yield ErrorProfileEditState(error: 'submit', user: user);
      }
    }
  }
}
