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
  final List<Category> categories;

  const StoreListTab(
      {Key key,
      @required this.setSelectedCats,
      @required this.stores,
      @required this.categories})
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
              child: FutureBuilder(
                builder: (context, snapshot) {
                  print(snapshot);
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return Container();
                  }
                  return RecentResearch(
                      categories: widget.categories,
                      recentSearches: snapshot.data);
                },
                future: getRecentSearch(),
              )),
          // Padding(padding: EdgeInsets.fromLTRB(10,20,0,0),
          // child: Recommended(),),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: AroundYou(
              categories: widget.categories,
              stores: widget.stores,
            ),
          ),
        ],
      ),
    );
  }
}
