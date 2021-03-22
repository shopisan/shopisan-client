import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/theme/colors.dart';

class DropdownMenu extends StatefulWidget {
  const DropdownMenu({Key key, this.setSelectedCats, @required this.categories})
      : super(key: key);

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
        height: 50,
        width: double.infinity,
        child: Form(
          child: Container(
            // height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: CustomColors.search,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MultiSelectDialogField(
                  buttonIcon: Icon(
                    Icons.search,
                    color: CustomColors.iconsActive,
                  ),
                  buttonText: Text(
                    AppLocalizations.of(context).search,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.iconsActive,
                    ),
                  ),
                  items: widget.categories.categories
                      .map((e) => MultiSelectItem(e.id, e.fr))
                      .toList(),
                  listType: MultiSelectListType.LIST,
                  chipDisplay: MultiSelectChipDisplay.none(),
                  onConfirm: (values) {
                    setState(() {
                      widget.setSelectedCats(values);
                    });
                  },
                  backgroundColor: CustomColors.search,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
