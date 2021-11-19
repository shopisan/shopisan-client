import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/components/Store/store_preview.dart';
import 'package:shopisan/model/Store.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.select((AuthenticationBloc bloc) => bloc.state);
    // double newHeight = getScreenHeight(context);

    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Text(
                AppLocalizations.of(context)!.favorite.toUpperCase(),
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            state is AuthenticationAuthenticated
                ? Flexible(
                    // height: newHeight - 64 - 70 - 32,
                    // width: double.infinity,
                    child: state.user.profile!.favouriteStores.length == 0
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.noFavYet,
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView(
                            children: state.user.profile!.favouriteStores.map((store) =>
                                    StorePreview(store: Store.fromJson(store)))
                                .toList(),
                          ))
                : Expanded(
                    child: Center(
                        child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      AppLocalizations.of(context)!.noFav,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  )))
          ],
        ));
  }
}
