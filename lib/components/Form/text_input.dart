import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopisan/theme/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final Function callback;
  final TextInputType keyboardType;
  final List<dynamic> inputFormatter;
  final bool isTextarea;

  TextInput(
      {@required this.controller,
      @required this.icon,
      @required this.label,
      this.callback,
      this.inputFormatter,
      this.keyboardType,
      this.isTextarea = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isTextarea ? null : 60,
      width: double.infinity,
      // padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: CustomColors.spreadRegister,
            spreadRadius: 5,
            blurRadius: 15,
          ),
        ],
      ),
      child: TextFormField(
        maxLines: null,
        controller: controller,
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: callback,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: CustomColors.iconsActive,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            labelText: label),
      ),
    );
  }
}
