import 'package:flutter/cupertino.dart';
import 'package:shopisan/components/EditStore/ProfileTab/CommercialPicture.dart';
import 'package:shopisan/components/EditStore/ProfileTab/ProfileCommercial.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({
    required this.store, required this.categories, required this.formKey});

  final Store store;
  final List<Category> categories;
  final GlobalKey<FormState> formKey;

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with AutomaticKeepAliveClientMixin {
  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SingleChildScrollView(child: Column(
        children: [
          CommercialPicture(store: widget.store),
          ProfileCommercial(store: widget.store, categories: widget.categories, formKey: widget.formKey,)
        ],
      ),)
    );
  }

  @override
  bool get wantKeepAlive => true;
}
