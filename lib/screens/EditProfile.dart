import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:shopisan/components/EditProfile/FormProfile.dart';
import 'package:shopisan/components/EditProfile/ProfilePicture.dart';
import 'package:shopisan/components/Form/save_button.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/model/UserProfileProfile.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserProfile user =
        context.select((ProfileEditBloc bloc) => bloc.state.user as UserProfile);
    final state = context.select((ProfileEditBloc bloc) => bloc.state);

    _setUser(username, email, name, surname, dob) {
      user.username = username;
      user.email = email;
      UserProfileProfile profile = user.profile as UserProfileProfile;
      profile.name = name;
      profile.surname = surname;
      profile.dob = dob;
    }

    _submitUser() {
      if (_formKey.currentState!.validate()) {
        BlocProvider.of<ProfileEditBloc>(context).add(SubmitEvent(user: user));
      }
    }

    if (state is InitialProfileEditState) {
      return LoadingIndicator();
    } else if (state is ErrorProfileEditState) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        // comme la snackbar est appelée avant le build du widget scaffold
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error == 'submit'
                ? AppLocalizations.of(context)!.profileError
                : AppLocalizations.of(context)!.profilePicError),
            backgroundColor: CustomColors.error,
          ),
        );
      });
    } else if (state is SuccessProfileEditState) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        // comme la snackbar est appelée avant le build du widget scaffold
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.profileSaved),
          backgroundColor: CustomColors.success,
        ));
      });
      BlocProvider.of<AuthenticationBloc>(context)
          .add(UserChangedEvent(user: state.user));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 8,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ProfilePicture(
                  user: user,
                ),
                FormProfile(
                  user: user,
                  setUser: _setUser,
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColors.textDark,
                    ),
                    child: state is LoadingProfileEditState
                        ? LoadingIndicator()
                        : SaveButton(callback: _submitUser))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
