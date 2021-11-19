import 'package:flutter/material.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/DetailsStoreList/Around.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/DetailsStoreList/DropdownCities.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/City.dart';
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
  final String selectedCountry;
  final ValueChanged<Object?> setCountry;
  final bool loading;
  final List<City> cities;
  final int selectedCity;
  final ValueChanged<Object?> setCity;
  final List<Category> categories;
  final List<Country> countries;

  const StoreListTab(
      {
      required this.setSelectedCats,
      required this.stores,
      required this.history,
      required this.selectedCats,
      required this.selectedCountry,
      required this.setCountry,
      required this.selectedCity,
      required this.setCity,
      required this.cities,
      required this.categories,
      required this.countries,
      this.loading = false})
      : super();

  @override
  _StoreListTabState createState() => _StoreListTabState();
}

class _StoreListTabState extends State<StoreListTab> {
  late AddressCollection addresses;

  late Map<DateTime, Category> categoryHistory;

  @override
  Widget build(BuildContext context) {
    List<Category> categories = widget.categories;
    List<Country> countries = widget.countries;

    double newHeight = getScreenHeight(context);
    int recentSearchHeight =
        (categories != null && widget.history.length != 0) ? 67 : 10;

    if(countries.length == 0){
      return LoadingIndicator();
    }

    //TODO ca doit attendre d'être chargé avant de s'afficher
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: DropdownCountry(
                countries: countries,
                selectedCountry: widget.selectedCountry,
                setCountry: widget.setCountry),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
            child: DropdownCities(
                cities: widget.cities,
                setCity: widget.setCity,
                selectedCity: widget.selectedCity),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
            child: DropdownMenu(
                categories: categories,
                setSelectedCats: widget.setSelectedCats,
                selectedCats: widget.selectedCats),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: RecentResearch(
                  categories: categories,
                  recentSearches: widget.history,
                  setSelectedCats: widget.setSelectedCats)),
          // Padding(padding: EdgeInsets.fromLTRB(10,20,0,0),
          // child: Recommended(),),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: AroundYou(
              stores: widget.stores,
              loading: widget.loading,
              // bottomNav - dropdownMenu - recentSearches - titre
              height: newHeight - 90 - 70 - 70 - 70 - recentSearchHeight - 59,
            ),
          ),
        ],
      ),
    );
  }
}
