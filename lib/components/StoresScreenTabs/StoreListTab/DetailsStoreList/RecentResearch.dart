import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class RecentResearch extends StatelessWidget {
  const RecentResearch(
      {
      required this.categories,
      required this.recentSearches,
      required this.setSelectedCats})
      : super();

  final List<Category> categories;
  final List<dynamic> recentSearches;
  final ValueChanged<List<dynamic>> setSelectedCats;

  @override
  Widget build(BuildContext context) {
    if (null == categories || recentSearches.length == 0) {
      return SizedBox(
        height: 10,
      );
    }

    Map<int, Category> categoryById = {};
    final String locale = getLocaleCode();

    for (Category cat in categories) {
      categoryById[cat.id] = cat;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              AppLocalizations.of(context)!.recentResearch.toUpperCase(),
              style: Theme.of(context).textTheme.headline2),
          SizedBox(
            height: 38,
            child: ListView(
              // reverse: true,
              scrollDirection: Axis.horizontal,
              children: recentSearches.reversed
                  .map(
                    (categoryId) => categoryById.containsKey(categoryId)
                        ? TextButton(
                            // style: ButtonStyle(minimumSize: MaterialStateProperty.all(value)<Size>),
                      style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                            onPressed: () {
                              setSelectedCats([categoryId]);
                            },
                            child: Container(
                              height: 30,
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: CustomColors.lightPink,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  categoryById[categoryId]!
                                      .toJson()[locale]
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.textDark,
                                  ),
                                ),
                              ),
                            ))
                        : Container(),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
