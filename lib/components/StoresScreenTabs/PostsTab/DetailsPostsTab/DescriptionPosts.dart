import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class DescriptionPosts extends StatefulWidget {


  @override
  _DescriptionPostsState createState() => _DescriptionPostsState();
}

class _DescriptionPostsState extends State<DescriptionPosts> {


  @override

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu quam nec erat feugiat sollicitudin non vitae nisl.",
              style: GoogleFonts.poppins(
                color: CustomColors.textDescription,
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Text("Price €", style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),)
        ],
      ),
    );
  }
}
