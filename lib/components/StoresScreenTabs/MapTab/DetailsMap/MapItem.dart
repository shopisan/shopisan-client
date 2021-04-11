import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

class MapItem extends StatelessWidget {
  const MapItem({Key key, @required this.stores, @required this.categories})
      : super(key: key);

  final List<Store> stores;
  final CategoryCollection categories;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        height: 70,
        width: width,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: stores
              .map((store) => TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/store_detail",
                          arguments: {"storeId": store.id});
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(right: 5),
                      child: /*Flexible(child:*/ Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: RatingBarIndicator(
                                    rating: store.evaluation != null ? store.evaluation : 2.5,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "${store.name}",
                              style: Theme.of(context).textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),/*),*/
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
