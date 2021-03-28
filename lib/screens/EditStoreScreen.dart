import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/components/EditStore/CommercialPicture.dart';
import 'package:shopisan/components/EditStore/ProfileCommercial.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class EditStore extends StatelessWidget {
  final int storeId;

  EditStore({@required this.storeId});

  @override
  Widget build(BuildContext context) {
    //todo récupérer le store depuis le state
    // todo créer le bloc

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
              CommercialPicture(),
              Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).profile,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ProfileCommercial(),
                  ],
                ),
              ),
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
