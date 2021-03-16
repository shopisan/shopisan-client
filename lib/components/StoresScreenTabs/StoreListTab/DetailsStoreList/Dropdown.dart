import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shopisan/theme/colors.dart';

class DropdownMenu extends StatefulWidget {
  const DropdownMenu({Key key}) : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String valueChoose;
  List listItem = [
    "Item 1", "Item 2", "Item 3", "Item 4"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: CustomColors.search,
      ),
      child: DropdownButton(
        hint: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.search, color: CustomColors.iconsActive,),
              Text("Search", style: GoogleFonts.poppins(
                color: CustomColors.iconsActive,
                fontSize: 16,
              ),
              ),
            ],
          ),
        ),
        iconSize: 0.0,
        underline: SizedBox(),
        isExpanded: true,
        value : valueChoose,
        onChanged: (newValue){
          setState(() {
            valueChoose = newValue;
          });
        },
        items: listItem.map((valueItem) {
          return DropdownMenuItem(
          value: valueItem,
          child: Container(
            padding: EdgeInsets.only(left: 15),
            child: Chip(
              backgroundColor: CustomColors.iconsActive,
              label: Text(valueItem, style: GoogleFonts.poppins(
                fontSize: 15,
                color: CustomColors.search,
              ),
              ),
              avatar: CircleAvatar(
                backgroundColor: CustomColors.search,
                child: Icon(Icons.cancel_outlined, color: CustomColors.iconsActive,),

              ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
