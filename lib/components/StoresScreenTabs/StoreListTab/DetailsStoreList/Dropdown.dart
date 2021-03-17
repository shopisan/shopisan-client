import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shopisan/models/Category.dart';
import 'package:shopisan/theme/colors.dart';

class DropdownMenu extends StatefulWidget {
  const DropdownMenu({Key key,
    this.setSelectedCats,
    @required this.categories
  }) : super(key: key);

  final CategoryCollection categories;
  final ValueChanged<List<dynamic>> setSelectedCats;

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  List<Category> selectedCategories;

  @override
  Widget build(BuildContext context) {
    if (null == widget.categories) {
      return Center(
        child: Text("Oh, no!"), // @todo remplacer par un loader
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
                    items: widget.categories.categories
                        .map((e) => MultiSelectItem(e.id, e.fr))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    chipDisplay: MultiSelectChipDisplay(),
                    onConfirm: (values) {
                      setState(() {
                        widget.setSelectedCats(values);
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
