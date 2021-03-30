import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:shopisan/components/EditProfile/FormProfile.dart';
import 'package:shopisan/components/EditProfile/ProfilePicture.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/model/UserProfileProfile.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final UserProfile user =
        context.select((ProfileEditBloc bloc) => bloc.state.user);
    final state = context.select((ProfileEditBloc bloc) => bloc.state);

    _setUser(username, email, name, surname, dob) {
      user.username = username;
      user.email = email;
      UserProfileProfile profile = user.profile;
      profile.name = name;
      profile.surname = surname;
      profile.dob = dob;
    }

    _submitUser() {
      BlocProvider.of<ProfileEditBloc>(context).add(SubmitEvent(user: user));
    }

    if (state is InitialProfileEditState) {
      return LoadingIndicator();
    } else if (state is ErrorProfileEditState) {
      // @todo afficher une snackbar avec l'erreur
      print("error message : ${state.error}");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // comme la snackbar est appelée avant le build du widget scaffold
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error == 'submit'
                ? AppLocalizations.of(context).profileError
                : AppLocalizations.of(context).profilePicError),
            backgroundColor: CustomColors.error,
          ),
        );
      });
    } else if (state is SuccessProfileEditState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // comme la snackbar est appelée avant le build du widget scaffold
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context).profileSaved),
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
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
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
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: CustomColors.iconsActive,
                ),
                child: state is LoadingProfileEditState
                    ? LoadingIndicator()
                    : TextButton(
                        onPressed: _submitUser,
                        child: Text(
                          AppLocalizations.of(context).save,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
