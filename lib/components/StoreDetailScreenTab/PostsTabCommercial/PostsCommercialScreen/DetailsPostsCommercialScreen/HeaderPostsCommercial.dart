import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderPostsCommercial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Product Name",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
