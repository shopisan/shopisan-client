import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class AroundYou extends StatelessWidget {
  const AroundYou({Key key, @required this.categories, @required this.stores})
      : super(key: key);

  final CategoryCollection categories;
  final List<Store> stores;

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
              children: stores
                  .map((store) => TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/store_detail",
                              arguments: store.id);
                        },
                        // padding: EdgeInsets.all(0),
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
                                  '${store.name}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black),
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
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
