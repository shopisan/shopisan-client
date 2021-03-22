import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/models/Category.dart';
import 'package:shopisan/models/Store.dart';
import 'package:shopisan/theme/colors.dart';

class CategoriesCommercial extends StatefulWidget {
  const CategoriesCommercial(
      {Key key, @required this.storeId, Store store, this.categories})
      : super(key: key);

  final int storeId;
  final CategoryCollection categories;

  @override
  _CategoriesCommercialState createState() => _CategoriesCommercialState();
}

class _CategoriesCommercialState extends State<CategoriesCommercial> {
  Store store;

  @override
  Widget build(BuildContext context) {
    if (null == widget.categories) {
      return LinearProgressIndicator();
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: CustomColors.commercialTag,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "${store.categories}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textResearch,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
