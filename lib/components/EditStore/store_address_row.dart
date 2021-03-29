import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/theme/colors.dart';


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
  final _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Address address = widget.address;
    final int index = widget.index;

    _streetController.text = address.streetAvenue;
    _cityController.text = address.city;
    _postalCodeController.text = address.postalCode;
    _countryController.text = address.country;

    List<TextEditingController> controllers = [
      _streetController, _cityController, _countryController, _postalCodeController
    ];

    _updateAddress(){
      address.streetAvenue = _streetController.text;
      address.postalCode = _postalCodeController.text;
      address.city = _cityController.text;
      address.country = _countryController.text;
      BlocProvider.of<EditStoreBloc>(context).add(StoreAddressEditEvent(address: address, index: index));
    }

    for (TextEditingController ctrl in controllers){
      ctrl.addListener(() {
        _updateAddress();
      });
    }

    _deleteAddress(){
      BlocProvider.of<EditStoreBloc>(context).add(RemoveAddressEvent(address: address));
    }

    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Column(
        children: [
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
          TextInput(
              controller: _countryController,
              icon: Icons.flag,
              label: AppLocalizations.of(context).country),
          ElevatedButton(
            onPressed: _deleteAddress,
            child: Icon(Icons.add),
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(CustomColors.error)),
          )
        ],
      ),
    );
  }
}

