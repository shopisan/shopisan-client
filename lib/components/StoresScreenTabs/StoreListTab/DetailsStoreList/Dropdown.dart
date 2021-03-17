import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shopisan/models/Category.dart';
import 'package:shopisan/theme/colors.dart';

class DropdownMenu extends StatefulWidget {
  const DropdownMenu({Key key}) : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  CategoryCollection categories;
  List<Category> selectedCategories;
  // String valueChoose;
  // List listItem = ["Item 1", "Item 2", "Item 3", "Item 4"];
  void fetchCategories() async {
    final response = await http.get(
        Uri.http("10.0.2.2:8000", "/api/stores/categories/"),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      // print(response.body);
      var truc = CategoryCollection.fromJson(jsonDecode(response.body));
      print(truc);
      // setState(() {
      //   categories = truc
      // });
    } else {
      throw Exception(
          'Failed to load categories, ca serait bien de faire quelque chose dans ce cas la');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    if (null == categories) {
      return Center(
        child: Text("Oh, no!"),
      );
    }

    return Container(
      child: Column(
        children: [
          Form(
              child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: CustomColors.search,
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MultiSelectDialogField(
                    items: categories.categories
                        .map((e) => MultiSelectItem(e.id, e.fr))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    chipDisplay: MultiSelectChipDisplay(),
                    onConfirm: (values) {
                      setState(() {
                        // selectedCategories = values;
                      });
                    },
                    backgroundColor: CustomColors.search,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    buttonIcon: Icon(
                      Icons.search,
                      color: CustomColors.iconsActive,
                    ),
                    buttonText: Text(
                      "Search",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.iconsActive,
                      ),
                    ),
                    itemsTextStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: CustomColors.iconsFaded,
                    ),
                    selectedItemsTextStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    selectedColor: CustomColors.iconsActive,
                  )
                ],
              ),
            ),
          ))
        ],
      ),

      // child: DropdownButton(
      //   hint: Container(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Icon(
      //           Icons.search,
      //           color: CustomColors.iconsActive,
      //         ),
      //         Text(
      //           AppLocalizations.of(context).helloWorld,
      //           style: GoogleFonts.poppins(
      //             color: CustomColors.iconsActive,
      //             fontSize: 16,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   iconSize: 0.0,
      //   underline: SizedBox(),
      //   isExpanded: true,
      //   value: valueChoose,
      //   onChanged: (newValue) {
      //     setState(() {
      //       valueChoose = newValue;
      //     });
      //   },
      //   items: listItem.map((valueItem) {
      //     return DropdownMenuItem(
      //       value: valueItem,
      //       child: Container(
      //         padding: EdgeInsets.only(left: 15),
      //         child: Chip(
      //           backgroundColor: CustomColors.iconsActive,
      //           label: Text(
      //             valueItem,
      //             style: GoogleFonts.poppins(
      //               fontSize: 15,
      //               color: CustomColors.search,
      //             ),
      //           ),
      //           avatar: CircleAvatar(
      //             backgroundColor: CustomColors.search,
      //             child: Icon(
      //               Icons.cancel_outlined,
      //               color: CustomColors.iconsActive,
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   }).toList(),
      // ),
    );
  }
}
