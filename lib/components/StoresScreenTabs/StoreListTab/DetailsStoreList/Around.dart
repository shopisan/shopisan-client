import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/components/Store/store_preview.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class AroundYou extends StatelessWidget {
  const AroundYou(
      {Key key, @required this.stores, @required this.height, this.loading})
      : super(key: key);

  final List<Store> stores;
  final double height;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Text(AppLocalizations.of(context).aroundYou.toUpperCase(),
                      style: Theme.of(context).textTheme.headline4),
                ],
              )),
          SizedBox(
              height: height,
              width: double.infinity,
              child: Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.only(bottom: 60),
                    scrollDirection: Axis.vertical,
                    children: stores
                        .map((store) => StorePreview(store: store))
                        .toList(),
                  ),
                  loading != true
                      ? Container()
                      : Positioned(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                    backgroundColor: CustomColors.lightPink,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        CustomColors.error))),
                          ),
                        )
                ],
              )

              // loading != true
              //     ? ListView(
              //         padding: EdgeInsets.only(bottom: 50),
              //         scrollDirection: Axis.vertical,
              //         children: stores
              //             .map((store) => StorePreview(store: store))
              //             .toList(),
              //       )
              //     : Align(
              //         alignment: Alignment.center,
              //         child: Container(
              //             height: 50,
              //             width: 50,
              //             child: CircularProgressIndicator(
              //                 backgroundColor: CustomColors.iconsActive,
              //                 valueColor: AlwaysStoppedAnimation<Color>(
              //                     CustomColors.error))),
              //       ),
              )
        ],
      ),
    );
  }
}
