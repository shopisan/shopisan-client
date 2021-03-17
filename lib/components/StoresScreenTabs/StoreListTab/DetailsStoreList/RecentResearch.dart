import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class RecentResearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "RECENT RESEARCH",
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
                  child: const Center(
                    child: Text(
                      "LEATHER",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.textResearch,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  decoration: BoxDecoration(
                      color: CustomColors.search,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "LEATHER",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.textResearch,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  decoration: BoxDecoration(
                      color: CustomColors.search,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "LEATHER",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.textResearch,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  decoration: BoxDecoration(
                      color: CustomColors.search,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "LEATHER",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.textResearch,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  decoration: BoxDecoration(
                      color: CustomColors.search,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "LEATHER",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.textResearch,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  decoration: BoxDecoration(
                      color: CustomColors.search,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "LEATHER",
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
