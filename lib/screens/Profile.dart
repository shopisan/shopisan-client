import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final state =
      context.select((AuthenticationBloc bloc) => bloc.state) ;
    UserProfile user;

    if (state is AuthenticationLoading) {
      return LoadingIndicator();
    }

    state as AuthenticationAuthenticated;
    // if (state is AuthenticationAuthenticated) {
      user = state.user;
    // }

    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Container(
              height: 80,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.search),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(AppLocalizations.of(context)!.profile,
                              style: Theme.of(context).textTheme.headline3),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/edit_profile');
                },
              )),
          Container( // Add contests code
              height: 80,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.search),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.qr_code_2_outlined,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(AppLocalizations.of(context)!.addCode,
                              style: Theme.of(context).textTheme.headline3),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/add_code');
                },
              )),
          user.isOwner! ?
          Container(
              height: 80,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.search),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.store_outlined,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(AppLocalizations.of(context)!.editStore,
                              style: Theme.of(context).textTheme.headline3),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/edit_stores');
                },
              )) : Container(),
          user.isOwner! ? Container(
              height: 80,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.search),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.post_add_outlined,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(AppLocalizations.of(context)!.editPosts,
                              style: Theme.of(context).textTheme.headline3),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/manage_post');
                },
              )) : Container(),
          Container(
              height: 80,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.search),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(AppLocalizations.of(context)!.logOut,
                              style: Theme.of(context).textTheme.headline3),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              )),
        ],
      ),
    );
  }
}
