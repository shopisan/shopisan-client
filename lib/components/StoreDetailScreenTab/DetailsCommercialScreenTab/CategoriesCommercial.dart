import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class CategoriesCommercial extends StatefulWidget {
  const CategoriesCommercial({Key key, @required this.store}) : super(key: key);

  final Store store;

  @override
  _CategoriesCommercialState createState() => _CategoriesCommercialState();
}

class _CategoriesCommercialState extends State<CategoriesCommercial> {
  Store store;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: 40,
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
                  "${widget.store.categories.map((category) => '${" " + category.fr + " "}')}",
                  style: TextStyle(
                    fontSize: 12,
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
