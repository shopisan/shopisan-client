import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/components/Store/store_preview.dart';
import 'package:shopisan/model/Store.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.select((AuthenticationBloc bloc) => bloc.state);

    return Container(
        child: Center(
      child: state is AuthenticationAuthenticated
          ? ListView(
              children: state.user.profile.favouriteStores
                  .map((store) => StorePreview(store: Store.fromJson(store)))
                  .toList(),
            )
          : Text("Page des stores préférés"),
    ));
  }
}
