import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/EditStore/CommercialPicture.dart';
import 'package:shopisan/components/EditStore/ProfileCommercial.dart';
import 'package:shopisan/components/Form/save_button.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

class EditStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.select((EditStoreBloc bloc) => bloc.state);
    final Store store = state.store;
    final List<Category> categories = state.categories;

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
              CommercialPicture(
                store: store,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context).profile.toUpperCase(),
                        style: Theme.of(context).textTheme.headline3),
                    ProfileCommercial(
                      store: store,
                      categories: categories,
                    ),
                  ],
                ),
              ),
              /* Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: CustomColors.iconsActive,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context).save,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
              ),*/
              SaveButton(callback: null)
            ],
          ),
        ),
      ),
    );
  }
}
