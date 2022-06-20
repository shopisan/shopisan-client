import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StorePreview extends StatelessWidget {
  final Store store;
  final String locale = getLocaleCode();

  StorePreview({required this.store});

  String _categoriesToString(List<Category> categories) {
    String str = "";
    int index = 0;
    for (Category cat in categories) {
      if (index > 0) {
        str += ", ";
      }
      str += cat.toJson()[locale];
      index++;
    }

    return str;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String? _image = store.profilePicture?.file;

    ImageProvider GetImage(){
      if (_image != null) {
        return CachedNetworkImageProvider(_image);
      }
      return AssetImage("assets/img/store.jpg");
    }

    double _GetRating(){
      if (store.evaluation != null) {
        return store.evaluation!;
      }
      return 0;
    }

    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/store_detail",
            arguments: {"storeId": store.id});
      },
      // padding: EdgeInsets.all(0),
      child: Row(
        children: [
          _image != null ?
          Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: GetImage())),
          ) :
          Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
            ),
            child: Center(child:  Icon(Icons.no_photography_outlined, color: CustomColors.textLight)),
          )
          ,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width - 70 - 60 - 10 - 10 - 20,
                    child: Text(
                      '${store.name}',
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: RatingBarIndicator(
                      rating: _GetRating(),
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 10,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  width: width - 70 - 10 - 10 - 20,
                  child: Text(
                    _categoriesToString(store.categories!)
                    /*"${store.categories.map((category) => '${" " + category.fr + " "}')}"*/,
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
              store.featured ?
                  Container(
                      width: width - 70 - 10 - 10 - 20,
                      child: Text(
                        "Featured",
                        style: Theme.of(context).textTheme.subtitle2,
                        /*maxLines: 2,
                        overflow: TextOverflow.ellipsis,*/
                      )) : Container()
            ],
          )
        ],
      ),
    );
  }
}
