import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  Widget build(BuildContext context) {
    if (null == widget.categories) {
      return Container(
        height: 50,
        child: LinearProgressIndicator(),
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
                )
              ],
            ),
          ),
        ));
  }
}
