import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/EditStore/AddressTab/store_address_row.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class AddressTab extends StatefulWidget {
  AddressTab({@required this.store});
  final Store store;

  @override
  _AddressTabState createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> {
  Store store;

  @override
  Widget build(BuildContext context) {
    _addAddress() {
      BlocProvider.of<EditStoreBloc>(context).add(AddAddressEvent());
    }

    return Container(
      child: Column(
        children: [
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
      ),
    );
  }
}
