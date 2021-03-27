import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shopisan/components/Form/date_input.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/model/UserProfileProfile.dart';
import 'package:shopisan/profile_edit/profile_edit_bloc.dart';

class FormProfile extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  final UserProfile user;
  final Function setUser;
  FormProfile({@required this.user, @required this.setUser});


  @override
  Widget build(BuildContext context) {
    final _userNameController = TextEditingController(text: user.username);
    final _emailController = TextEditingController(text: user.email);
    final _nameController = TextEditingController(text: user.profile.name);
    final _surnameController = TextEditingController(text: user.profile.surname);
    final _dobController = TextEditingController(text: user.profile.dob);

    List<TextEditingController> controllers = [
      _userNameController, _emailController, _nameController,
      _surnameController, _dobController
    ];

    _updateUser(){
      setUser(_userNameController.text, _emailController.text,
          _nameController.text, _surnameController.text, _dobController.text);
    }

    for (TextEditingController ctrl in controllers){
      ctrl.addListener(() {
        _updateUser();
      });
    }

    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                user.username,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            TextInput(controller: _userNameController, icon: Icons.verified_user_outlined, label: AppLocalizations.of(context).userName,),
            TextInput(controller: _emailController, icon: Icons.mail_outline, label: AppLocalizations.of(context).emailAddress,),
            Padding(padding: EdgeInsets.all(10)),
            TextInput(controller: _nameController, icon: Icons.account_circle_outlined, label: AppLocalizations.of(context).name,),
            TextInput(controller: _surnameController, icon: Icons.account_circle_outlined, label: AppLocalizations.of(context).lastName,),
            DateInput(controller: _dobController, icon: Icons.cake_outlined, format: format,),
          ],
        ));
  }
}
