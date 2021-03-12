import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/theme/colors.dart';

class DropdownMenu extends StatefulWidget {
  const DropdownMenu({Key key}) : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String dropdownValue = 'Search';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.search_outlined),
        iconSize: 24,
        elevation: 0,
        style: const TextStyle(color: CustomColors.lightRed),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['One', 'Two', 'Tree', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
