import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class ManagePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              decoration: BoxDecoration(
                  color: CustomColors.iconsActive,
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton.icon(
                icon: Icon(
                  Icons.post_add_outlined,
                  color: Colors.black,
                ),
                label: Text(
                  AppLocalizations.of(context).createPost,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/create_post');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
