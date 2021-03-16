import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class ConnectCommercial extends StatefulWidget {
  @override
  _ConnectCommercialState createState() => _ConnectCommercialState();
}

class _ConnectCommercialState extends State<ConnectCommercial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20,20,20,20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("CONNECT WITH US",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColors.commercialTag,
                ),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                margin: EdgeInsets.only(top: 20),
                height: 35,
                width: 150,
                // ignore: deprecated_member_use
                child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      // site internet commerce
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.pageview_outlined, color: Colors.white,),
                        Text("WEBSITE", style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ), ),
                      ],
                    )

                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColors.commercialBlue,
                ),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                margin: EdgeInsets.only(top: 20),
                height: 35,
                width: 150,
                // ignore: deprecated_member_use
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    // site internet commerce
                  },
                  child:
                  Text("FACEBOOK", style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ), ),
                ),

              ),
            ],
          )
        ],
      ),
    );
  }
}
