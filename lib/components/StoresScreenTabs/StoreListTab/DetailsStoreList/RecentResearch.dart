import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/theme/colors.dart';

class RecentResearch extends StatelessWidget {
  const RecentResearch(
      {Key key, @required this.categories, @required this.recentSearches})
      : super(key: key);

  final List<Category> categories;
  final List<dynamic> recentSearches;

  @override
  Widget build(BuildContext context) {
    if (null == categories) {
      return SizedBox(
        height: 10,
      );
    }

    Map<int, Category> categoryById = {};

    for (Category cat in categories){
      categoryById[cat.id] = cat;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).recentResearch.toUpperCase(),
              style: Theme.of(context).textTheme.headline4),
          SizedBox(
            height: 40,
            child: ListView(
              // reverse: true,
              scrollDirection: Axis.horizontal,

              children:
                recentSearches.reversed.map((categoryId) =>
                  categoryById.containsKey(categoryId) ?
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: CustomColors.search,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "${categoryById[categoryId].fr}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.textDark,
                          ),
                        ),
                      ),
                    ) : Container(),
                ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
