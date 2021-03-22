import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectCommercial extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const ConnectCommercial({Key, key, @required this.storeId}) : super(key: key);

  final int storeId;

  @override
  _ConnectCommercialState createState() => _ConnectCommercialState();
}

class _ConnectCommercialState extends State<ConnectCommercial> {
  Store store;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).connectCommercial,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.transparent,
                padding: EdgeInsets.all(0),
                onPressed: _launcherURL,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustomColors.commercialTag,
                  ),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 35,
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.pageview_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        "WEBSITE",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                padding: EdgeInsets.all(0),
                color: Colors.transparent,
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustomColors.commercialBlue,
                  ),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 35,
                  width: 150,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      // site internet commerce
                    },
                    child: Text(
                      "FACEBOOK",
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _launcherURL() async => await canLaunch("${store.website}")
      ? await launch("${store.website}")
      : throw "Could not launch ('${store.website}')";
}
