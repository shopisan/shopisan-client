import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/Form/text_input.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';
import 'package:shopisan/utils/validators.dart';

class ProfileCommercial extends StatefulWidget {
  final Store store;
  final List<Category> categories;
  final GlobalKey<FormState> formKey;

  ProfileCommercial(
      {required this.store,
      required this.categories,
      required this.formKey});

  @override
  _ProfileCommercialState createState() => _ProfileCommercialState();
}

class _ProfileCommercialState extends State<ProfileCommercial>
    with AutomaticKeepAliveClientMixin {
  final _nameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _descriptionControllerFr = TextEditingController();
  final _descriptionControllerEn = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Store store = widget.store;
    final String locale = getLocaleCode();

    _nameController.text = store.name;
    _descriptionControllerFr.text = store.description_fr;
    _descriptionControllerEn.text = store.description_en;
    _websiteController.text = store.website ?? "";

    List<int> _initialCats = [];
    if (store.categories != null) {
      for (Category cat in store.categories!) {
        _initialCats.add(cat.id);
      }
    }

    List<TextEditingController> controllers = [
      _nameController,
      _descriptionControllerFr,
      _descriptionControllerEn,
      _websiteController
    ];

    if (null == store) {
      return LoadingIndicator();
    }

    _updateValues() {
      store.name = _nameController.text;
      store.description_fr = _descriptionControllerFr.text;
      store.description_en = _descriptionControllerEn.text;
      store.website = _websiteController.text;
      BlocProvider.of<EditStoreBloc>(context).add(StoreEditEvent(store: store));
    }

    for (TextEditingController ctrl in controllers) {
      ctrl.addListener(() {
        _updateValues();
      });
    }

    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              controller: _nameController,
              icon: Icons.store_outlined,
              label: AppLocalizations.of(context)!.storeName,
              validator: isEmpty,
            ),
            TextInput(
              controller: _descriptionControllerEn,
              icon: Icons.store_outlined,
              label: AppLocalizations.of(context)!.description + " " + AppLocalizations.of(context)!.english,
              keyboardType: TextInputType.multiline,
              isTextarea: true,
              // validator: isEmpty,
            ),
            TextInput(
              controller: _descriptionControllerFr,
              icon: Icons.store_outlined,
              label: AppLocalizations.of(context)!.description + " " + AppLocalizations.of(context)!.french,
              keyboardType: TextInputType.multiline,
              isTextarea: true,
              // validator: isEmpty,
            ),
            TextInput(
              controller: _websiteController,
              icon: Icons.web,
              label: AppLocalizations.of(context)!.website,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text(
                AppLocalizations.of(context)!.searchCat.toUpperCase(),
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            MultiSelectDialogField(
              buttonIcon: Icon(
                Icons.search,
                color: CustomColors.iconsActive,
              ),
              buttonText: Text(AppLocalizations.of(context)!.searchCat,
                  style: Theme.of(context).textTheme.bodyText1),
              items: null != widget.categories
                  ? widget.categories
                      .map((e) => MultiSelectItem(e.id, e.toJson()[locale]))
                      .toList()
                  : [],
              initialValue: _initialCats,
              listType: MultiSelectListType.LIST,
              onConfirm: (values) {
                BlocProvider.of<EditStoreBloc>(context)
                    .add(StoreEditCategoriesEvent(categoriesIds: values));
              },
              title: Text(AppLocalizations.of(context)!.categories),
              confirmText: Text(
                "Ok",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: CustomColors.iconsActive,
                    fontWeight: FontWeight.bold),
              ),
              cancelText: Text(AppLocalizations.of(context)!.cancel,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: CustomColors.iconsActive,
                    fontWeight: FontWeight.bold),),
              backgroundColor: CustomColors.search,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border:
                    Border.all(color: CustomColors.spreadRegister, width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
