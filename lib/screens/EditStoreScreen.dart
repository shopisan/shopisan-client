import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/EditStore/AddressTab/address_tab.dart';
import 'package:shopisan/components/EditStore/OpeningHoursTab/opening_form_tab.dart';
import 'package:shopisan/components/EditStore/ProfileTab/profile_tab.dart';
import 'package:shopisan/components/Form/save_button.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class EditStore extends StatefulWidget {
  @override
  _EditStoreState createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  int _currentIndex = 0;

  final _formKey = GlobalKey<FormState>();

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.store_outlined,
            size: 35,
          ),
          label: "Profile"),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.lock_clock,
            size: 35,
          ),
          label: "Time"),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.location_pin,
            size: 35,
          ),
          label: "Address")
    ];
  }

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((EditStoreBloc bloc) => bloc.state);

    if (state is DoneEditStoreState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).storeSaved),
            backgroundColor: CustomColors.success,
          ),
        );
      });
    }

    if (state is InitialEditStoreState) {
      return LoadingIndicator();
    }

    final Store store = state.store;
    final List<Category> categories = state.categories;

    List<Widget> _getListTab(Store store) {
      return <Widget>[
        ProfileTab(
          store: store,
          categories: categories,
        ),
        OpeningHoursTab(store: store),
        AddressTab(store: store)
      ];
    }

    _submitForm() {
      if (_formKey.currentState.validate()) {
        BlocProvider.of<EditStoreBloc>(context).add(StoreSubmitEvent());
      }
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 8,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocalizations.of(context).editStore,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              // padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              children: [
                _getListTab(store).elementAt(_currentIndex),
                Container(
                  padding: EdgeInsets.all(20),
                  child: SaveButton(callback: _submitForm),
                )
              ]),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              spreadRadius: 10,
              blurRadius: 30,
              color: CustomColors.spread,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: _navBarsItems(),
          currentIndex: _currentIndex,
          selectedItemColor: CustomColors.iconsActive,
          onTap: _onTapped,
          unselectedItemColor: CustomColors.iconsFaded,
          showUnselectedLabels: false,
        ),
      ),

      // SingleChildScrollView(
      //   child: Container(
      //     padding: EdgeInsets.all(10),
      //     child: Column(
      //       children: [
      //         CommercialPicture(
      //           store: store,
      //         ),
      //         Container(
      //           padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Text(AppLocalizations.of(context).profile.toUpperCase(),
      //                   style: Theme.of(context).textTheme.headline3),
      //               ProfileCommercial(
      //                 store: store,
      //                 categories: categories,
      //               ),
      //             ],
      //           ),
      //         ),
      //         SaveButton(callback: _submitForm),
      //       ],
      //     ),
      //   ),
      // ),
    ));
  }
}
