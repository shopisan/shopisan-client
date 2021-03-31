import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/res/country_codes.dart' as CountryCodes;

class StoreAddressRow extends StatefulWidget {
  final Address address;
  final int index;

  StoreAddressRow({@required this.address, this.index});

  @override
  _StoreAddressRowState createState() => _StoreAddressRowState();
}

class _StoreAddressRowState extends State<StoreAddressRow> {
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String selectedCountry;

  @override
  Widget build(BuildContext context) {
    final Address address = widget.address;
    final int index = widget.index;

    _streetController.text = address.streetAvenue;
    _cityController.text = address.city;
    _postalCodeController.text = address.postalCode;
    selectedCountry = address.country;

    List<TextEditingController> controllers = [
      _streetController, _cityController,
      _postalCodeController
    ];

    _updateAddress() {
      address.streetAvenue = _streetController.text;
      address.postalCode = _postalCodeController.text;
      address.city = _cityController.text;
      address.country = selectedCountry;
      BlocProvider.of<EditStoreBloc>(context)
          .add(StoreAddressEditEvent(address: address, index: index));
    }

    for (TextEditingController ctrl in controllers) {
      ctrl.addListener(() {
        _updateAddress();
      });
    }

    _deleteAddress() {
      BlocProvider.of<EditStoreBloc>(context)
          .add(RemoveAddressEvent(address: address));
    }

    _getCountryText(countryCode){
      String text = AppLocalizations.of(context).country;
      if (null != countryCode) {
        CountryCodes.countryCodes.forEach((element) {
          if (element['iso2_cc'] == countryCode) {
            text = element['name'];
          }
        });
      }

      return text;
    }

    print("getCountryText: ${_getCountryText(selectedCountry)}");

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: Text(
                  AppLocalizations.of(context).local.toUpperCase(),
                  style: Theme.of(context).textTheme.headline3,
                ),
              )
            ],
          ),
          TextInput(
              controller: _streetController,
              icon: Icons.location_pin,
              label: AppLocalizations.of(context).street),
          TextInput(
              controller: _cityController,
              icon: Icons.location_city,
              label: AppLocalizations.of(context).city),
          TextInput(
              controller: _postalCodeController,
              icon: Icons.location_searching,
              label: AppLocalizations.of(context).postCode),
          /*TextInput(
              controller: _countryController,
              icon: Icons.flag,
              label: AppLocalizations.of(context).country),*/
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(EdgeInsets.all(0))),
              onPressed: (){
            showCountryPicker(context: context, onSelect: (Country country){
              setState(() {
                selectedCountry = country.countryCode;
              });
              _updateAddress();
            });
          }, child: Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.spreadRegister,
                    spreadRadius: 5,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Row(children: [
                Icon(
                  Icons.flag,
                  color: CustomColors.iconsActive,
                ),
                Padding(padding: EdgeInsets.all(8)),
                Text(_getCountryText(selectedCountry), style: TextStyle(color: CustomColors.textDescription),)
              ],))),
      Container(
        margin: EdgeInsets.only(top: 10),
        width: 50,
        child: ElevatedButton(
          onPressed: _deleteAddress,
          child: Icon(
            Icons.delete,
            size: 15,
          ),
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(CustomColors.error),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
        ),)
        ],
      ),
    );
  }
}
