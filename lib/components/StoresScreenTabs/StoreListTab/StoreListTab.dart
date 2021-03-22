import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/DetailsStoreList/Around.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

import 'DetailsStoreList/Dropdown.dart';
import 'DetailsStoreList/RecentResearch.dart';

class StoreListTab extends StatefulWidget {
  @override
  _StoreListTabState createState() => _StoreListTabState();
}

class _StoreListTabState extends State<StoreListTab> {
  Store store;
  CategoryCollection categories;
  AddressCollection addresses;
  List<dynamic> selectedCategoriesId;
  Map<DateTime, Category> categoryHistory;

  void loadStores() async {
    print(selectedCategoriesId);
    // @todo reste à définir la localisation
    Map<String, dynamic> params = {};

    if (selectedCategoriesId != null) {
      params['categories'] = selectedCategoriesId.join(",");
    }

    final response = await http.get(
        Uri.http("10.0.2.2:8000", "/api/stores_geo/", params),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
    } else {
      throw Exception('Failed to load stores');
    }
  }

  void fetchCategories() async {
    final response = await http.get(
        Uri.http("10.0.2.2:8000", "/api/stores/categories/"),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      setState(() {
        categories = CategoryCollection.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception(
          'Failed to load categories, ca serait bien de faire quelque chose dans ce cas la');
    }
  }

  void saveSearchHistory(List<dynamic> catIds) {
    /**
     * @todo categories --> selon les ids retrouver la bonne cat
     * @todo dans le storage save les dernières cats recherchées
     */
  }

  Future<List<dynamic>> getRecentSearch() async {
    List recentSearches = [];

    /**
     * @todo quand catégories selectionnée, ajouter des rows dans les categoryHistory
     * @todo trier pour que chaque category n'apparaisse qu'une fois par ordre chrono
     * @todo injecter ca dans le widget recent search
     */

    return recentSearches;
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    loadStores();
  }

  void setSelectedCats(List<dynamic> selectedCats) async {
    setState(() {
      selectedCategoriesId = selectedCats;
    });
    loadStores();

    // @todo ajouter dans categoryHistory (associer par datetime) + save dans storage
    // @todo reload les stores a afficher
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: DropdownMenu(
                categories: categories, setSelectedCats: setSelectedCats),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: FutureBuilder(
                builder: (context, snapshot) {
                  print(snapshot);
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return Container();
                  }
                  return RecentResearch(
                      categories: categories, recentSearches: snapshot.data);
                },
                future: getRecentSearch(),
              )),
          // Padding(padding: EdgeInsets.fromLTRB(10,20,0,0),
          // child: Recommended(),),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: AroundYou(
                categories: categories, addresses: addresses, store: store),
          ),
        ],
      ),
    );
  }
}
