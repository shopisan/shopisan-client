import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shopisan/CountryTranslation/iso_country_translation.dart';
import 'package:shopisan/model/Country.dart';
import 'package:shopisan/theme/colors.dart';

class DropdownCountry extends StatefulWidget {
  const DropdownCountry(
      {Key key,
      @required this.setCountries,
      @required this.countries,
      @required this.selectedCountries})
      : super(key: key);

  final List<Country> countries;
  final ValueChanged<List<dynamic>> setCountries;
  final List selectedCountries;

  @override
  _DropdownCountryState createState() => _DropdownCountryState();
}

class _DropdownCountryState extends State<DropdownCountry> {
  @override
  Widget build(BuildContext context) {
    if (null == widget.countries) {
      return Container(
        height: 50,
        child: LinearProgressIndicator(),
      );
    }

    // print(widget.countries);
    // print("widget selected countries: ${widget.selectedCountries}");

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
                  initialValue: widget.selectedCountries,
                  buttonIcon: Icon(
                    Icons.search,
                    color: CustomColors.iconsActive,
                  ),
                  buttonText: Text(AppLocalizations.of(context).countries,
                      style: Theme.of(context).textTheme.headline6),
                  items: widget.countries
                      .map((e) => MultiSelectItem(e.iso, /*_getCountryText(e.iso)*/IsoCountryTranslation.getCountryName(e.iso)))
                      .toList(),
                  listType: MultiSelectListType.LIST,
                  chipDisplay: MultiSelectChipDisplay.none(),
                  onConfirm: (values) {
                    setState(() {
                      widget.setCountries(values);
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
