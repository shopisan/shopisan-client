import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DescriptionTabCommercial/DescriptionTabCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DetailsCommercialScreenTab/CategoriesCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DetailsCommercialScreenTab/RatingBarCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/MapTabCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/PostsTabCommercial/PostsTabCommercial.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/OpeningTime.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/theme/colors.dart';

class StoreDetailScreen extends StatefulWidget {
  const StoreDetailScreen({Key key, @required this.storeId}) : super(key: key);

  final int storeId;

  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  Store store;
  AddressCollection addresses;
  List<Category> categories;
  OpeningTime openingTime;
  List<Post> posts;

  int _currentIndex = 0;

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        backgroundColor: Colors.white,
        icon: Icon(Icons.store_outlined, size: 40),
        label: ("About"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.newspaper, size: 40),
        label: ("Posts"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map_outlined, size: 40),
        label: ("Map"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
    ];
  }

  Future<Store> getStore() async {
    final response = await http.get(
        Uri.http("10.0.2.2:8000", "/api/stores/stores/${widget.storeId}/"),
        headers: {'Accept': 'application/json'});
    try {
      if (response.statusCode == 200) {
        return Store.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      print("Oops: $Exception");
    }
    return null;
  }

  void getCategories() async {
    List<Category> categoryList = await fetchCategories();

    setState(() {
      categories = categoryList;
    });
  }

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _getListTab(Store store) {
    return <Widget>[
      DescriptionTabCommercial(
        store: store,
      ),
      PostsTabCommercial(store: store, posts: posts,),
      // MapTabCommercial(addresses: addresses),
      MapTabCommercial(store: store),
    ];
  }

  @override
  void initState() {
    fetchStore(widget.storeId).then((value) {
      setState(() {
        store = value;
      });
      return value.id;
    }).then((storeId){
      fetchPostsByStore(storeId).then((value){
        setState(() {
          posts = value;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (null == store) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: CustomColors.lightBlue,
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  height: 250,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Image(
                        image: store.profilePicture != null ?
                            NetworkImage(store.profilePicture.file) :
                        AssetImage("assets/img/store.jpg"),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                          top: 30,
                          left: 20,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              CustomColors.lightBlue)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_left_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Container(
                                  width: 250,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${store.name}",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                            ],
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBarCommercial(store: store,),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: CustomColors.lightBlue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FavoriteButton(
                                    iconSize: 30,
                                    valueChanged: () async {
                                      try {
                                        UserProfile user =
                                            await manageFavouriteStore(
                                                store.id);
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(UserChangedEvent(user: user));
                                      } catch (exception) {
                                        print(
                                            "Oops, error during handling favourite store adding");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                CategoriesCommercial(
                  store: store,
                ),
                _getListTab(store).elementAt(_currentIndex),
              ],
            ),
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
          ),
        ),
      ),
    );
  }
}
