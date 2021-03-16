import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class MapItem extends StatefulWidget {
  @override
  _MapItemState createState() => _MapItemState();
}

class _MapItemState extends State<MapItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: SizedBox(
          height: 100,
          width: 400,
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: () {
              // todo screen commerce
            },
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          // image local
                          width: 120,
                          height: 50,
                          padding: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Local", style: GoogleFonts.poppins(
                                fontSize : 14,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Commercial", style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          // image local
                          width: 120,
                          height: 50,
                          padding: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Local", style: GoogleFonts.poppins(
                                fontSize : 14,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Commercial", style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          // image local
                          width: 120,
                          height: 50,
                          padding: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Local", style: GoogleFonts.poppins(
                                fontSize : 14,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Commercial", style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          // image local
                          width: 120,
                          height: 50,
                          padding: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Local", style: GoogleFonts.poppins(
                                fontSize : 14,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Commercial", style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          // image local
                          width: 120,
                          height: 50,
                          padding: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Local", style: GoogleFonts.poppins(
                                fontSize : 14,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Commercial", style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          // image local
                          width: 120,
                          height: 50,
                          padding: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Local", style: GoogleFonts.poppins(
                                fontSize : 14,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Commercial", style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: CustomColors.textDescription,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),

        ),
    );

  }
}
