import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/CountryTranslation/iso_country_translation.dart';
import 'package:shopisan/components/Form/CustomMonoSelect/chip_display/multi_select_chip_display.dart';
import 'package:shopisan/components/Form/CustomMonoSelect/dialog/multi_select_dialog_field.dart';
import 'package:shopisan/components/Form/CustomMonoSelect/multi_select_flutter.dart';
import 'package:shopisan/model/Country.dart';
import 'package:shopisan/theme/colors.dart';

class DropdownCountry extends StatefulWidget {
  const DropdownCountry(
      {
      required this.setCountry,
      required this.countries,
      required this.selectedCountry})
      : super();

  final List<Country> countries;
  final ValueChanged<Object?> setCountry;
  final String selectedCountry;

  @override
  _DropdownCountryState createState() => _DropdownCountryState();
}

class _DropdownCountryState extends State<DropdownCountry> {
  bool initialized = false;

  @override
  Widget build(BuildContext context) {

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
                  initialValue: widget.selectedCountry,
                  buttonIcon: Icon(
                    Icons.search,
                    color: CustomColors.iconsActive,
                  ),
                  buttonText: Text(AppLocalizations.of(context)!.countries,
                      style: Theme.of(context).textTheme.headline6),
                  items: widget.countries
                      .map((e) => MultiSelectItem(
                          e.iso, IsoCountryTranslation.getCountryName(e.iso)))
                      .toList(),
                  listType: MultiSelectListType.LIST,
                  chipDisplay: MultiSelectChipDisplay.none(),
                  onConfirm: (value) {
                    setState(() {
                      widget.setCountry(value);
                    });
                  },
                  backgroundColor: CustomColors.search,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  cancelText: Text(
                    AppLocalizations.of(context)!.cancel,
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
                    AppLocalizations.of(context)!.select,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
