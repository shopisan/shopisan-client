import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DescriptionTabCommercial/DescriptionTabCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DetailsCommercialScreenTab/RatingBarCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/MapTabCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/PostsTabCommercial/PostsTabCommercial.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/OpeningTime.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/model/UserProfileProfile.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

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
        // icon: Icon(Icons.store_outlined, size: 35),
        icon: FaIcon(
          FontAwesomeIcons.store,
          size: 30,
        ),
        label: ("About"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        // icon: FaIcon(FontAwesomeIcons.newspaper, size: 35),
        icon: FaIcon(
          FontAwesomeIcons.solidClone,
          size: 30,
        ),
        label: ("Posts"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
      BottomNavigationBarItem(
        // icon: Icon(Icons.map_outlined, size: 35),
        icon: FaIcon(
          FontAwesomeIcons.mapMarkedAlt,
          size: 30,
        ),
        label: ("Map"),
        // activeColor: CustomColors.activeBlue,
        // inactiveColor: CustomColors.systemGrey,
      ),
    ];
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

  @override
  void initState() {
    fetchStore(widget.storeId).then((value) {
      setState(() {
        store = value;
      });
      return value.id;
    }).then((storeId) {
      fetchPostsByStore(storeId).then((value) {
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
      return LoadingIndicator();
    }

    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newHeight = height - padding.top - padding.bottom;

    List<Widget> _getListTab(Store store) {
      return <Widget>[
        DescriptionTabCommercial(
          store: store,
          height: newHeight,
        ),
        PostsTabCommercial(
          store: store,
          posts: posts,
          height: newHeight,
        ),
        MapTabCommercial(
          store: store,
          height: newHeight,
        ),
      ];
    }

    final AuthenticationState state =
        context.select((AuthenticationBloc bloc) => bloc.state);
    UserProfileProfile profile;
    if (state is AuthenticationAuthenticated) {
      profile = state.user.profile;
    }

    _submitFavourite() async {
      try {
        UserProfile user = await manageFavouriteStore(store.id);
        BlocProvider.of<AuthenticationBloc>(context)
            .add(UserChangedEvent(user: user));
      } catch (exception) {
        print("Oops, error during handling favourite store");
      }
    }

    _isFavourite() {
      if (null != profile) {
        for (Map<String, dynamic> storeJson in profile.favouriteStores) {
          if (storeJson['id'] == store.id) {
            return true;
          }
        }
      }

      return false;
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
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
                      image: store.profilePicture != null
                          ? NetworkImage(store.profilePicture.file)
                          : AssetImage("assets/img/store.jpg"),
                      fit: BoxFit.cover,
                      height: 250,
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
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 8),
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
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBarCommercial(
                                store: store,
                                profile: profile,
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: CustomColors.lightBlue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: FavoriteButton(
                                  isFavorite: _isFavourite(),
                                  iconSize: 30,
                                  valueChanged: (_favourite) {
                                    if (null != profile) {
                                      _submitFavourite();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        key: Key("yup"),
                                        content: Text(
                                            AppLocalizations.of(context)
                                                .loginRequired),
                                        backgroundColor: CustomColors.error,
                                        action: SnackBarAction(
                                          textColor: Colors.white,
                                          label: AppLocalizations.of(context)
                                              .logIn
                                              .toUpperCase(),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed("/",
                                                arguments: {"toLogin": true});
                                          },
                                        ),
                                      ));
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
              _getListTab(store).elementAt(_currentIndex),
            ],
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
      ),
    );
  }
}
