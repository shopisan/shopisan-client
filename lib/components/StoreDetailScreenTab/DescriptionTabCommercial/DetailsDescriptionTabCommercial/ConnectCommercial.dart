import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectCommercial extends StatefulWidget {
  const ConnectCommercial({Key key, @required this.store}) : super(key: key);

  final Store store;

  @override
  _ConnectCommercialState createState() => _ConnectCommercialState();
}

class _ConnectCommercialState extends State<ConnectCommercial> {
  @override
  Widget build(BuildContext context) {
    Store store = widget.store;
    return Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(AppLocalizations.of(context).connectCommercial.toUpperCase(),
            //     style: Theme.of(context).textTheme.headline3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  // color: Colors.transparent,
                  // padding: EdgeInsets.all(0),
                  onPressed: () {
                    _launcherURL(store);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColors.lightPink,
                    ),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 35,
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.pageview_outlined,
                          color: CustomColors.textDark,
                        ),
                        Text(
                          AppLocalizations.of(context).website,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  void _launcherURL(store) async {
    bool resp = await canLaunch("${store.website}");
    await canLaunch("${store.website}")
        ? await launch("${store.website}")
        : throw "Could not launch ('${store.website}')";
  }
}
