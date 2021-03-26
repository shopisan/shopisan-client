import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/theme/colors.dart';

class RecentResearch extends StatelessWidget {
  const RecentResearch(
      {Key key, @required this.categories, @required this.recentSearches})
      : super(key: key);

  final List<Category> categories;
  final List<dynamic> recentSearches;

  @override
  Widget build(BuildContext context) {
    if (null == categories) {
      return SizedBox(
        height: 10,
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).recentResearch,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  decoration: BoxDecoration(
                      color: CustomColors.search,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "$recentSearches",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.textResearch,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
