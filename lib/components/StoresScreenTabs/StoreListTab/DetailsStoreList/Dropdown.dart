import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class DropdownMenu extends StatefulWidget {
  const DropdownMenu(
      {Key key,
      @required this.setSelectedCats,
      @required this.categories,
      @required this.selectedCats})
      : super(key: key);

  final List<Category> categories;
  final ValueChanged<List<dynamic>> setSelectedCats;
  final List selectedCats;

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  List<Category> selectedCategories;
  final String locale = getLocaleCode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (null == widget.categories) {
      return Container(
        height: 50,
        child: LinearProgressIndicator(),
      );
    }
    print(widget.selectedCats);
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
                initialValue: widget.selectedCats,
                buttonIcon: Icon(
                  Icons.search,
                  color: CustomColors.iconsActive,
                ),
                buttonText: Text(AppLocalizations.of(context).categories,
                    style: Theme.of(context).textTheme.headline6),
                items: widget.categories
                    .map((e) => MultiSelectItem(e.id, e.toJson()[locale]))
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
                cancelText: Text(
                  AppLocalizations.of(context).cancel,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: CustomColors.iconsActive,
                      fontWeight: FontWeight.bold),
                ),
                confirmText: Text(
                  "Ok",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: CustomColors.iconsActive,
                      fontWeight: FontWeight.bold),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).select,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextButton(
                      onPressed: () {
                        widget.setSelectedCats([]);
                        // setState(() {});
                        // Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context).deleteCats,
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: CustomColors.iconsActive,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
