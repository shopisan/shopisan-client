import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class EditStoreSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationState state =
        context.select((AuthenticationBloc bloc) => bloc.state);
    if (state is AuthenticationAuthenticated) {
      UserProfile user = state.user;

      print(user.profile.ownedStores);

      final List<Widget> storeList = [];
      for (Store store in user.profile.ownedStores) {
        storeList.add(EditStoreLink(storeName: store.name, storeId: store.id));
      }
      storeList.add(EditStoreLink(
          storeName: AppLocalizations.of(context).addStore, storeId: null));

      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              AppLocalizations.of(context).editStore,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          body: SingleChildScrollView(child: Column(children: storeList)));
    } else {
      return LoadingIndicator();
    }
  }
}

class EditStoreLink extends StatelessWidget {
  final String storeName;
  final int storeId;

  EditStoreLink({@required this.storeName, @required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
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
                    child: Text(storeName,
                        style: Theme.of(context).textTheme.headline2),
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
            Navigator.pushNamed(context, '/edit_store', arguments: storeId);
          },
        ));
  }
}
