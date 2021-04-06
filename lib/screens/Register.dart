import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/blocs/registration/registration_bloc.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final RegistrationState state =
        context.select((RegistrationBloc bloc) => bloc.state);
    final Map<String, String> data = state.data;

    List<TextEditingController> controllers = [
      _userNameController,
      _emailController,
      _passwordController,
      _repeatPasswordController
    ];

    _changeData() {
      BlocProvider.of<RegistrationBloc>(context)
          .add(ChangedRegistrationEvent(data: {
        "email": _emailController.text,
        "username": _userNameController.text,
        "password": _passwordController.text,
        "passwordRepeat": _repeatPasswordController.text
      }));
    }

    for (TextEditingController ctl in controllers) {
      ctl.addListener(() {
        _changeData();
      });
    }

    _submitRegistration() {
      if (_formKey.currentState.validate()) {
        BlocProvider.of<RegistrationBloc>(context)
            .add(SubmitRegistrationEvent(data: data));
      }
    }

    List<Widget> _getMsgText(List<String> data) {
      List<Widget> list = [];
      for (String err in data) {
        switch (err) {
          case 'email_taken':
            list.add(Text(AppLocalizations.of(context).emailTaken));
            break;
          case 'userName_taken':
            list.add(Text(AppLocalizations.of(context).userNameTaken));
            break;
          default:
            list.add(Text(""))
                /*AppLocalizations.of(context).*/;
        }
      }

      return list;
    }

    if (state is DoneRegistrationState) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: state.success
              ? Text(AppLocalizations.of(context).accountCreated)
              : Column(
                  children: _getMsgText(state.message),
                  mainAxisSize: MainAxisSize.min,
                ),
          backgroundColor:
              state.success ? CustomColors.success : CustomColors.error,
        ));
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              constraints: BoxConstraints.expand(),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).signUp,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextInput(
                        controller: _userNameController,
                        icon: null,
                        label: AppLocalizations.of(context).userName,
                        noIcon: true,
                        margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                        padding: EdgeInsets.only(left: 10),
                        hint: AppLocalizations.of(context).userName,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _emailController,
                        icon: null,
                        label: AppLocalizations.of(context).emailAddress,
                        noIcon: true,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        padding: EdgeInsets.only(left: 10),
                        hint: AppLocalizations.of(context).emailHint,
                        validator: isValidEmail,
                      ),
                      TextInput(
                        controller: _passwordController,
                        icon: null,
                        label: AppLocalizations.of(context).password,
                        noIcon: true,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        padding: EdgeInsets.only(left: 10),
                        hint: AppLocalizations.of(context).passHint,
                        obscureText: true,
                        validator: isEmpty,
                      ),
                      TextInput(
                        controller: _repeatPasswordController,
                        icon: null,
                        label: AppLocalizations.of(context).passwordConfirm,
                        noIcon: true,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        padding: EdgeInsets.only(left: 10),
                        hint: AppLocalizations.of(context).passwordConfirm,
                        obscureText: true,
                        validator: passwordsMatch,
                        passwordValidation: _passwordController.text,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: CustomColors.textDark,
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.spreadRegister,
                              spreadRadius: 5,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            _submitRegistration();
                          },
                          child: Text(
                            AppLocalizations.of(context).signUp,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register_store');
                        },
                        child: Text(
                          AppLocalizations.of(context).signUpStore,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
