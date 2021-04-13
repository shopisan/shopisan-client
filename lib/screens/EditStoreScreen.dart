import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
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

class _EditStoreState extends State<EditStore>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final _formProfileKey = GlobalKey<FormState>();
  final _formAddressKey = GlobalKey<FormState>();

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double realHeight = height - padding.top - padding.bottom;

    final state = context.select((EditStoreBloc bloc) => bloc.state);
    final authBloc = context.select((AuthenticationBloc bloc) => bloc);

    controller.addListener(() {
      setState(() {
        _currentIndex = controller.index;
      });
    });

    if (state is InitialEditStoreState) {
      return LoadingIndicator();
    }

    final Store store = state.store;
    final List<Category> categories = state.categories;

    if (state is DoneEditStoreState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).storeSaved),
            backgroundColor: CustomColors.success,
          ),
        );
        BlocProvider.of<EditStoreBloc>(context).add(StoreEditEvent(store: store));
      });
    }

    if (state is ErrorEditStoreState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).anErrorOccurred),
            backgroundColor: CustomColors.error,
          ),
        );
        BlocProvider.of<EditStoreBloc>(context).add(StoreEditEvent(store: store));
      });
    }

    _submitForm() {
      bool prevent = false;
      if (_formAddressKey.currentState == null) {
        if (store.id == null) {
          controller.animateTo(2);
          prevent = true;
        }
      } else {
        prevent = !_formAddressKey.currentState.validate();
      }

      if (_formProfileKey.currentState.validate() && !prevent) {
        BlocProvider.of<EditStoreBloc>(context).add(
            StoreSubmitEvent(authBloc: authBloc));
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
      body: SizedBox(
          height: realHeight - 48 - 56,
          child: Column(
            children: [
              Expanded(child: TabBarView(
                controller: controller,
                children: <Widget>[
                  ProfileTab(
                    store: store,
                    categories: categories,
                    formKey: _formProfileKey,
                  ),
                  OpeningHoursTab(
                    store: store,
                  ),
                  AddressTab(store: store, formKey: _formAddressKey)
                ],
              ),),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: SaveButton(callback: _submitForm),
              )
            ]),),
      bottomNavigationBar: TabBar(
        controller: controller,
        tabs: <Widget>[
          Tab( child: Icon(
            Icons.store_outlined,
            size: 35,
            color: _currentIndex == 0 ?
              CustomColors.iconsActive :
              CustomColors.iconsFaded,
          ),),
          Tab(child: Icon(
            Icons.lock_clock,
            size: 35,
            color: _currentIndex == 1 ? CustomColors.iconsActive : CustomColors.iconsFaded,
          ),),
          Tab(child: Icon(
            Icons.location_pin,
            size: 35,
            color: _currentIndex == 2 ? CustomColors.iconsActive : CustomColors.iconsFaded,
          ),),
        ],
      ),
    ));
  }
}
