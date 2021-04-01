import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class RatingBarCommercial extends StatefulWidget {
  final Store store;

  RatingBarCommercial({@required this.store});

  @override
  _RatingBarCommercialState createState() => _RatingBarCommercialState();
}

class _RatingBarCommercialState extends State<RatingBarCommercial> {
  @override
  Widget build(BuildContext context) {
    final Store store = widget.store;

    print("Store $store");

    return Container(
      padding: EdgeInsets.all(10),
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: CustomColors.lightBlue,
          ),
        ),
        splashColor: Colors.black,
        color: CustomColors.lightBlue,
        child: RatingBarIndicator(
          rating: store?.evaluation ?? 2.5,
          direction: Axis.horizontal,
          itemCount: 5,
          itemSize: 15,
          itemPadding: EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
        onPressed: () => _onButtonPressed(store),
      ),
    );
  }

  void _onButtonPressed(Store store) {
    print("store2: $store");
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      AppLocalizations.of(context).evaluation,
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textDark),
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: store?.evaluation ?? 2.5,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) async {
                      print(rating);
                      print(store);
                      bool rslt = await postEvaluation(store.id, rating);
                      // @todo afficher snackbar (Merci pour votre évaluation)

                    },
                    glow: true,
                  ),
                ]),
          );
        });
  }
}
