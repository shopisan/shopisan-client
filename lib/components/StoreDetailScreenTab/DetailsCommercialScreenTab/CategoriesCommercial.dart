import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class CategoriesCommercial extends StatefulWidget {
  const CategoriesCommercial({required this.store}) : super();

  final Store store;

  @override
  _CategoriesCommercialState createState() => _CategoriesCommercialState();
}

class _CategoriesCommercialState extends State<CategoriesCommercial> {
  final String locale = getLocaleCode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: widget.store.categories!
              .map((category) => Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: CustomColors.lightPink,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        category.toJson()[locale].toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textDark,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
