import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/DetailsStoreList/Around.dart';
import 'DetailsStoreList/Dropdown.dart';
import 'DetailsStoreList/RecentResearch.dart';
import 'package:shopisan/models/Category.dart';

class StoreListTab extends StatefulWidget {
  @override
  _StoreListTabState createState() => _StoreListTabState();
}

class _StoreListTabState extends State<StoreListTab> {
  CategoryCollection categories;
  List<dynamic> selectedCategoriesId;

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
      throw Exception(
          'Failed to load stores');
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

  @override
  void initState() {
    super.initState();
    fetchCategories();
    loadStores();
  }

  void setSelectedCats(List<dynamic>selectedCats) async {
    setState(() {
      selectedCategoriesId = selectedCats;
    });
    print("changed selected categories");
    print(selectedCategoriesId);
    loadStores();
    // @todo reload les stores a afficher
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25,20,25,20),
            child: DropdownMenu(categories: categories, setSelectedCats: setSelectedCats),
          ),
          Padding(padding: EdgeInsets.only(left: 10),
            child: RecentResearch(),
          ),
          // Padding(padding: EdgeInsets.fromLTRB(10,20,0,0),
          // child: Recommended(),),
          Padding(padding: EdgeInsets.fromLTRB(10,20,0,0),
          child: AroundYou(),),
        ],
      ),
);
  }
}
