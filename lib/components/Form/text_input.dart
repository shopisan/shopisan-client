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
  final bool noIcon;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final String hint;
  final bool obscureText;

  TextInput(
      {@required this.controller,
      @required this.icon,
      @required this.label,
      this.callback,
      this.inputFormatter,
      this.keyboardType,
      this.isTextarea = false,
      this.noIcon = false,
      this.padding,
      this.margin,
      this.hint,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isTextarea ? null : 50,
      width: double.infinity,
      padding: padding,
      margin: margin ?? EdgeInsets.only(top: 20),
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
        maxLines: isTextarea ? null : 1,
        controller: controller,
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: callback,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: noIcon
                ? null
                : Icon(
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
            labelText: label,
            hintText: hint),
      ),
    );
  }
}
