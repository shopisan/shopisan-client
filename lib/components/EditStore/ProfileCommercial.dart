import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/EditStore/opening_hours_form.dart';
import 'package:shopisan/components/EditStore/store_address_row.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class ProfileCommercial extends StatelessWidget {
  final Store store;
  final List<Category> categories;

  ProfileCommercial({@required this.store, @required this.categories});

  final _nameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addAddress() {
      BlocProvider.of<EditStoreBloc>(context).add(AddAddressEvent());
    }

    if (null == store) {
      return LoadingIndicator();
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInput(
              controller: _nameController,
              icon: Icons.store_outlined,
              label: AppLocalizations.of(context).storeName),
          TextInput(
            controller: _descriptionController,
            icon: Icons.store_outlined,
            label: AppLocalizations.of(context).description,
            keyboardType: TextInputType.multiline,
            isTextarea: true,
          ),
          TextInput(
              controller: _websiteController,
              icon: Icons.web,
              label: AppLocalizations.of(context).website),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
            child: Text(
              AppLocalizations.of(context).searchCat.toUpperCase(),
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
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
            items: null != categories
                ? categories.map((e) => MultiSelectItem(e.id, e.fr)).toList()
                : [],
            listType: MultiSelectListType.LIST,
            // chipDisplay: MultiSelectChipDisplay.none(),
            onConfirm: (values) {
              //@todo update les catégories depuis le bloc
            },
            backgroundColor: CustomColors.search,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
            child: Text(
              AppLocalizations.of(context).selectHours.toUpperCase(),
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: CustomColors.search,
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(5),
            child: CheckboxListTile(
                checkColor: Colors.white,
                activeColor: CustomColors.iconsActive,
                value: store.appointmentOnly,
                title: Text(
                  AppLocalizations.of(context).appointmentOnly.toUpperCase(),
                  style: Theme.of(context).textTheme.headline2,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  store.appointmentOnly = value;
                  BlocProvider.of<EditStoreBloc>(context)
                      .add(StoreEditEvent(store: store));
                }),
          ),

          store.appointmentOnly
              ? Column()
              : OpeningHoursForm(
                  store: store,
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
                width: 50,
                child: ElevatedButton(
                  onPressed: _addAddress,
                  child: Icon(
                    Icons.add,
                    size: 15,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(CustomColors.success),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
              ),
            ],
          )

          // @todo ajouter une input pour gérer les heures d'ouvertures
          // @todo ajouter une collection pour gérer les addresses
        ],
      ),
    );
  }
}
