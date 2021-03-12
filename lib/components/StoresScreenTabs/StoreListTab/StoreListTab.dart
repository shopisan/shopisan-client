import 'package:flutter/material.dart';

import 'DetailsStoreList/Dropdown.dart';
// import 'package:shopisan/components/StoreList/List.dart';
//
// class StoreListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(),
//       // child: StoreList()//,
//     );
//   }
// }

class StoreListTab extends StatefulWidget {
  @override
  _StoreListTabState createState() => _StoreListTabState();
}

class _StoreListTabState extends State<StoreListTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: DropdownMenu(),
          ),
        ],
      ),
    );
  }
}
