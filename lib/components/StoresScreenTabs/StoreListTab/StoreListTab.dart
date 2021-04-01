import 'package:flutter/material.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/components/StoresScreenTabs/StoreListTab/DetailsStoreList/Around.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

import 'DetailsStoreList/Dropdown.dart';
import 'DetailsStoreList/RecentResearch.dart';

class StoreListTab extends StatefulWidget {
  final ValueChanged<List<dynamic>> setSelectedCats;
  final List<Store> stores;
  final List<dynamic> history;

  const StoreListTab(
      {Key key,
      @required this.setSelectedCats,
      @required this.stores,
      @required this.history})
      : super(key: key);

  @override
  _StoreListTabState createState() => _StoreListTabState();
}

class _StoreListTabState extends State<StoreListTab> {
  List<Category> categories = [];
  AddressCollection addresses;

  Map<DateTime, Category> categoryHistory;

  void getCategories() async {
    List<Category> catColl = await fetchCategories();

    setState(() {
      categories = catColl;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
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
                categories: categories,
                setSelectedCats: widget.setSelectedCats),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: RecentResearch(
                  categories: categories,
                  recentSearches: widget.history)),
          // Padding(padding: EdgeInsets.fromLTRB(10,20,0,0),
          // child: Recommended(),),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: AroundYou(
              stores: widget.stores,
            ),
          ),
        ],
      ),
    );
  }
}
