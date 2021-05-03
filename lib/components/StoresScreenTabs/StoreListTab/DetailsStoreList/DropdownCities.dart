import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/components/Form/CustomMonoSelect/chip_display/multi_select_chip_display.dart';
import 'package:shopisan/components/Form/CustomMonoSelect/dialog/multi_select_dialog_field.dart';
import 'package:shopisan/components/Form/CustomMonoSelect/multi_select_flutter.dart';
import 'package:shopisan/model/City.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';


class DropdownCities extends StatefulWidget {
  const DropdownCities(
      {Key key,
      @required this.setCity,
      @required this.cities,
      @required this.selectedCity})
      : super(key: key);

  final List<City> cities;
  final ValueChanged<int> setCity;
  final int selectedCity;

  @override
  _DropdownCitiesState createState() => _DropdownCitiesState();
}

class _DropdownCitiesState extends State<DropdownCities> {
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    final String locale = getLocaleCode();

    _getCityItems(){
      List<MultiSelectItem> items = [];

      items.add(MultiSelectItem(0, AppLocalizations.of(context).myLocation));

      if (null != widget.cities) {
        for (City city in widget.cities) {
          items.add(MultiSelectItem(city.id, city.getNameLocale(locale)));
        }
      }

      return items;
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
                CustomMonoSelect(
                  initialValue: widget.selectedCity,
                  buttonIcon: Icon(
                    Icons.search,
                    color: CustomColors.iconsActive,
                  ),
                  buttonText: Text(AppLocalizations.of(context).city,
                      style: Theme.of(context).textTheme.headline6),
                  items: _getCityItems(),
                  searchable: true,
                  listType: MultiSelectListType.LIST,
                  chipDisplay: MultiSelectChipDisplay.none(),
                  onConfirm: (value) {
                    setState(() {
                      widget.setCity(value);
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
                  title: Text(
                    AppLocalizations.of(context).select,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
