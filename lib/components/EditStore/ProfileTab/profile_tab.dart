import 'package:flutter/cupertino.dart';
import 'package:shopisan/components/EditStore/ProfileTab/CommercialPicture.dart';
import 'package:shopisan/components/EditStore/ProfileTab/ProfileCommercial.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key key, @required this.store, @required this.categories})
      : super(key: key);

  final Store store;
  final List<Category> categories;

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CommercialPicture(store: widget.store),
          ProfileCommercial(store: widget.store, categories: widget.categories)
        ],
      ),
    );
  }
}
