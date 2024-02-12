import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DescriptionTabCommercial/DescriptionTabCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DescriptionTabCommercial/DetailsDescriptionTabCommercial/AddressesCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DescriptionTabCommercial/DetailsDescriptionTabCommercial/ConnectCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DescriptionTabCommercial/DetailsDescriptionTabCommercial/OpeningTimeCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/DetailsCommercialScreenTab/RatingBarCommercial.dart';
import 'package:shopisan/components/StoreDetailScreenTab/MapTabCommercial.dart';
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
  const StoreDetailScreen({required this.storeId}) : super();

  final int storeId;

  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  Store? store;
  AddressCollection? addresses;
  List<Category>? categories;
  OpeningTime? openingTime;
  List<Post>? posts;

  int _currentIndex = 0;

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        backgroundColor: Colors.white,
        icon: FaIcon(
          FontAwesomeIcons.store,
          size: 30,
        ),
        label: AppLocalizations.of(context)!.store,
      ),
      BottomNavigationBarItem(
        icon: FaIcon(
          FontAwesomeIcons.mapMarker,
          size: 30,
        ),
        label: AppLocalizations.of(context)!.map,
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
    _loadStuffs();
    super.initState();
  }

  _loadStuffs() async {
    var loadStore = fetchStore(widget.storeId);
    var loadPosts = fetchPostsByStore(widget.storeId);

    Store leStore = await loadStore;
    List<Post> lesPosts = await loadPosts;

    setState(() {
      store = leStore;
      posts = lesPosts;
    });
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
          posts: posts!,
        ),
        MapTabCommercial(
          store: store,
          height: newHeight,
        ),
      ];
    }

    final AuthenticationState state =
        context.select((AuthenticationBloc bloc) => bloc.state);
    UserProfileProfile? profile;
    if (state is AuthenticationAuthenticated) {
      profile = state.user.profile!;
    }

    _submitFavourite() async {
      try {
        UserProfile user = await manageFavouriteStore(store!.id as int);
        BlocProvider.of<AuthenticationBloc>(context)
            .add(UserChangedEvent(user: user));
      } catch (exception) {
        print("Oops, error during handling favourite store");
      }
    }

    _isFavourite() {
      if (null != profile) {
        for (Map<String, dynamic> storeJson in profile.favouriteStores) {
          if (storeJson['id'] == store!.id) {
            return true;
          }
        }
      }
      return false;
    }

    ImageProvider _GetImage(){
      if (store!.profilePicture != null) {
        return CachedNetworkImageProvider(store!.profilePicture!.file!);
      }
      return AssetImage("assets/img/store.jpg");
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
                      image: _GetImage(),
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.keyboard_arrow_left_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "${store!.name}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Colors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textWidthBasis:
                                            TextWidthBasis.longestLine,
                                      ),
                                      width: getScreenWidth(context) - 80,
                                    )
                                  ],
                                )),
                            IconButton(
                              icon: Icon(Icons.info_outline,
                                  size: 30, color: Colors.white),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SafeArea(
                                        child: SingleChildScrollView(
                                      child: Column(
                                        //mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .about
                                                  .toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          store?.openingTimes != null ?
                                          OpeningTimeCommercial(
                                            store: store!,
                                          ) : Container(),
                                          ConnectCommercial(
                                            store: store!,
                                          ),
                                          AddressesCommercial(store: store!)
                                        ],
                                      ),
                                    ));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBarCommercial(
                                store: store!,
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
                                          .showSnackBar(
                                        SnackBar(
                                          key: Key("yup"),
                                          content: Text(
                                              AppLocalizations.of(context)!
                                                  .loginRequired),
                                          backgroundColor: CustomColors.error,
                                          action: SnackBarAction(
                                            textColor: Colors.white,
                                            label: AppLocalizations.of(context)!
                                                .logIn
                                                .toUpperCase(),
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  "/",
                                                  arguments: {"toLogin": true});
                                            },
                                          ),
                                        ),
                                      );
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
              _getListTab(store!).elementAt(_currentIndex),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                spreadRadius: 5,
                blurRadius: 5,
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
