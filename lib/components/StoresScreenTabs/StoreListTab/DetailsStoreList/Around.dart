import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/models/Category.dart';
import 'package:shopisan/screens/CommercialScreen.dart';
import 'package:shopisan/theme/colors.dart';

class AroundYou extends StatelessWidget {
  const AroundYou({Key key, this.setSelectedCats, @required this.categories})
      : super(key: key);

  final CategoryCollection categories;
  final ValueChanged<List<dynamic>> setSelectedCats;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AROUND YOU",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height),
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CommercialScreen()));
                  },
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Luckyteam",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "52 rue du président Edouard Herriot, 69002 Lyon",
                            style: GoogleFonts.poppins(
                              color: CustomColors.textDescription,
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
