import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  ProfileCommercial({@required this.store, @required this.categories, @required this.formKey});

  @override
  _ProfileCommercialState createState() => _ProfileCommercialState();
}

class _ProfileCommercialState extends State<ProfileCommercial>  with AutomaticKeepAliveClientMixin {
  final _nameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Store store = widget.store;

    _nameController.text = store.name;
    _descriptionController.text = store.description;
    _websiteController.text = store.website;

    List<int> _initialCats = [];
    if (store.categories != null) {
      for (Category cat in store.categories) {
        _initialCats.add(cat.id);
      }
    }

    List<TextEditingController> controllers = [
      _nameController,
      _descriptionController,
      _websiteController
    ];

    // _addAddress() {
    //   BlocProvider.of<EditStoreBloc>(context).add(AddAddressEvent());
    // }

    if (null == store) {
      return LoadingIndicator();
    }

    _updateValues() {
      store.name = _nameController.text;
      store.description = _descriptionController.text;
      store.website = _websiteController.text;
      BlocProvider.of<EditStoreBloc>(context)
          .add(StoreEditEvent(store: store));
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
              label: AppLocalizations.of(context).storeName,
              validator: isEmpty,
            ),
            TextInput(
              controller: _descriptionController,
              icon: Icons.store_outlined,
              label: AppLocalizations.of(context).description,
              keyboardType: TextInputType.multiline,
              isTextarea: true,
              validator: isEmpty,
            ),
            TextInput(
              controller: _websiteController,
              icon: Icons.web,
              label: AppLocalizations.of(context).website,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
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
              buttonText: Text(AppLocalizations.of(context).searchCat,
                  style: Theme.of(context).textTheme.bodyText1),
              items: null != widget.categories
                  ? widget.categories.map((e) => MultiSelectItem(e.id, e.fr)).toList()
                  : [],
              initialValue: _initialCats,
              listType: MultiSelectListType.LIST,
              // chipDisplay: MultiSelectChipDisplay.none(),
              onConfirm: (values) {
                BlocProvider.of<EditStoreBloc>(context)
                    .add(StoreEditCategoriesEvent(categoriesIds: values));
              },
              backgroundColor: CustomColors.search,
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


// class ProfileCommercial extends StatelessWidget {
//   final Store store;
//   final List<Category> categories;
//   final GlobalKey<FormState> formKey;
//
//   ProfileCommercial({@required this.store, @required this.categories, @required this.formKey});
//
//   final _nameController = TextEditingController();
//   final _websiteController = TextEditingController();
//   final _descriptionController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     _nameController.text = store.name;
//     _descriptionController.text = store.description;
//     _websiteController.text = store.website;
//
//     List<int> _initialCats = [];
//     if (store.categories != null) {
//       for (Category cat in store.categories) {
//         _initialCats.add(cat.id);
//       }
//     }
//
//     List<TextEditingController> controllers = [
//       _nameController,
//       _descriptionController,
//       _websiteController
//     ];
//
//     // _addAddress() {
//     //   BlocProvider.of<EditStoreBloc>(context).add(AddAddressEvent());
//     // }
//
//     if (null == store) {
//       return LoadingIndicator();
//     }
//
//     _updateValues() {
//         store.name = _nameController.text;
//         store.description = _descriptionController.text;
//         store.website = _websiteController.text;
//         BlocProvider.of<EditStoreBloc>(context)
//             .add(StoreEditEvent(store: store));
//     }
//
//     for (TextEditingController ctrl in controllers) {
//       ctrl.addListener(() {
//         _updateValues();
//       });
//     }
//
//     return Container(
//       margin: EdgeInsets.all(10),
//       child: Form(
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextInput(
//               controller: _nameController,
//               icon: Icons.store_outlined,
//               label: AppLocalizations.of(context).storeName,
//               validator: isEmpty,
//             ),
//             TextInput(
//               controller: _descriptionController,
//               icon: Icons.store_outlined,
//               label: AppLocalizations.of(context).description,
//               keyboardType: TextInputType.multiline,
//               isTextarea: true,
//               validator: isEmpty,
//             ),
//             TextInput(
//               controller: _websiteController,
//               icon: Icons.web,
//               label: AppLocalizations.of(context).website,
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
//               child: Text(
//                 AppLocalizations.of(context).searchCat.toUpperCase(),
//                 style: Theme.of(context).textTheme.headline3,
//               ),
//             ),
//             MultiSelectDialogField(
//               buttonIcon: Icon(
//                 Icons.search,
//                 color: CustomColors.iconsActive,
//               ),
//               buttonText: Text(AppLocalizations.of(context).searchCat,
//                   style: Theme.of(context).textTheme.bodyText1),
//               items: null != categories
//                   ? categories.map((e) => MultiSelectItem(e.id, e.fr)).toList()
//                   : [],
//               initialValue: _initialCats,
//               listType: MultiSelectListType.LIST,
//               // chipDisplay: MultiSelectChipDisplay.none(),
//               onConfirm: (values) {
//                 BlocProvider.of<EditStoreBloc>(context)
//                     .add(StoreEditCategoriesEvent(categoriesIds: values));
//               },
//               backgroundColor: CustomColors.search,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(40),
//                 boxShadow: [
//                   BoxShadow(
//                     color: CustomColors.spreadRegister,
//                     spreadRadius: 5,
//                     blurRadius: 15,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
