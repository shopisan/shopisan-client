import 'package:flutter/material.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/DetailsStoreList/Around.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Country.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/utils/common.dart';

import 'DetailsStoreList/Dropdown.dart';
import 'DetailsStoreList/DropdownCountry.dart';
import 'DetailsStoreList/RecentResearch.dart';

class StoreListTab extends StatefulWidget {
  final ValueChanged<List<dynamic>> setSelectedCats;
  final List<Store> stores;
  final List<dynamic> history;
  final List selectedCats;
  final List selectedCountries;
  final ValueChanged<List<dynamic>> setCountries;
  final bool loading;

  const StoreListTab(
      {Key key,
      @required this.setSelectedCats,
      @required this.stores,
      @required this.history,
      @required this.selectedCats,
      @required this.selectedCountries,
      @required this.setCountries,
      this.loading})
      : super(key: key);

  @override
  _StoreListTabState createState() => _StoreListTabState();
}

class _StoreListTabState extends State<StoreListTab> {
  List<Category> categories = [];
  List<Country> countries = [];
  AddressCollection addresses;

  Map<DateTime, Category> categoryHistory;

  void getCategories() async {
    var catTemp = fetchCategories();
    var countriesQuery = fetchCountries();
    List<Category> catColl = await catTemp;
    List<Country> countriesTemp = await countriesQuery;

    setState(() {
      categories = catColl;
      countries = countriesTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    double newHeight = getScreenHeight(context);
    int recentSearchHeight =
        (categories != null && widget.history.length != 0) ? 67 : 10;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: DropdownMenu(
                categories: categories,
                setSelectedCats: widget.setSelectedCats,
                selectedCats: widget.selectedCats),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
            child: DropdownCountry(
                countries: countries,
                selectedCountries: widget.selectedCountries,
                setCountries: widget.setCountries),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: RecentResearch(
                  categories: categories, recentSearches: widget.history)),
          // Padding(padding: EdgeInsets.fromLTRB(10,20,0,0),
          // child: Recommended(),),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: AroundYou(
              stores: widget.stores,
              loading: widget.loading,
              // bottomNav - dropdownMenu - recentSearches - titre
              height: newHeight - 73 - 90 - recentSearchHeight - 47 - 20,
            ),
          ),
        ],
      ),
    );
  }
}
