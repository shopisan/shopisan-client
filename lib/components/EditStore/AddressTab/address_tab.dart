import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/EditStore/AddressTab/store_address_row.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class AddressTab extends StatefulWidget {
  AddressTab({@required this.store, @required this.formKey});
  final Store store;
  final GlobalKey<FormState> formKey;

  @override
  _AddressTabState createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    Store store = widget.store;
    _addAddress() {
      BlocProvider.of<EditStoreBloc>(context).add(AddAddressEvent());
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Form(key: widget.formKey,
      child: SingleChildScrollView(child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Text(
                  AppLocalizations.of(context).local.toUpperCase(),
                  style: Theme.of(context).textTheme.headline3,
                ),
              )
            ],
          ),
          Column(
            children: store.addresses
                .asMap()
                .map((index, Address address) => MapEntry(
                index, StoreAddressRow(address: address, index: index)))
                .values
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 50,
                child: ElevatedButton(
                  onPressed: _addAddress,
                  child: Icon(Icons.add, size: 15),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          CustomColors.success),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)))),
                ),
              ),
            ],
          ),
        ],
      ),)),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
